const Post = require("../models/Post");
const Category = require("../models/Category");
const { generatePinterestContent } = require("../services/gemini.service");
const categoryService = require("../services/category.service");

// POST /posts — Create post + generate Pinterest content
const createPost = async (req, res) => {
  try {
    const {
      amazon_url,
      affiliated_link,
      image_urls,
      category,
      raw_title,
      raw_description,
      status,
      image_generated,
    } = req.body;

    if (!amazon_url || !raw_title || !raw_description || !category) {
      return res.status(400).json({
        success: false,
        message: "amazon_url, raw_title, raw_description, and category are required",
      });
    }

    // Validate category exists
    const categoryDoc = await Category.findById(category);
    if (!categoryDoc) {
      return res.status(404).json({ success: false, message: "Category not found" });
    }

    // Generate Pinterest content via Gemini
    const aiContent = await generatePinterestContent({
      title: raw_title,
      description: raw_description,
      category: categoryDoc.name,
    });

    const post = await Post.create({
      amazon_url,
      affiliated_link: affiliated_link || null,
      image_urls: image_urls || [],
      category,
      ...aiContent,
      status: status || "draft",
      image_generated: image_generated || "yet_to_generate",
    });

    await post.populate("category", "name");

    categoryService.incrementTotalPins(category, 1).catch((err) =>
      console.error("incrementTotalPins failed:", err)
    );

    return res.status(201).json({
      success: true,
      message: "Post created successfully",
      data: post,
    });
  } catch (error) {
    console.error("createPost error:", error);
    return res.status(500).json({ success: false, message: error.message });
  }
};

// PUT /posts/:id — Update post, regenerate only if regenerate: true
const updatePost = async (req, res) => {
  try {
    const { id } = req.params;
    const {
      amazon_url,
      affiliated_link,
      image_urls,
      category,
      raw_title,
      raw_description,
      status,
      image_generated,
      regenerate,
    } = req.body;

    const post = await Post.findById(id);
    if (!post) {
      return res.status(404).json({ success: false, message: "Post not found" });
    }

    // Build update object with only provided fields
    const updateData = {};
    if (amazon_url !== undefined) updateData.amazon_url = amazon_url;
    if (affiliated_link !== undefined) updateData.affiliated_link = affiliated_link;
    if (image_urls !== undefined) updateData.image_urls = image_urls;
    if (status !== undefined) updateData.status = status;
    if (image_generated !== undefined) updateData.image_generated = image_generated;

    if (category !== undefined) {
      const categoryDoc = await Category.findById(category);
      if (!categoryDoc) {
        return res.status(404).json({ success: false, message: "Category not found" });
      }
      updateData.category = category;
    }

    // Only regenerate AI content if explicitly requested
    if (regenerate === true) {
      if (!raw_title || !raw_description) {
        return res.status(400).json({
          success: false,
          message: "raw_title and raw_description are required when regenerate is true",
        });
      }

      const categoryDoc = category
        ? await Category.findById(category)
        : await Category.findById(post.category);

      const aiContent = await generatePinterestContent({
        title: raw_title,
        description: raw_description,
        category: categoryDoc.name,
      });

      Object.assign(updateData, aiContent);
    }

    const updated = await Post.findByIdAndUpdate(id, updateData, {
      new: true,
      runValidators: true,
    }).populate("category", "name");

    return res.status(200).json({
      success: true,
      message: "Post updated successfully",
      data: updated,
    });
  } catch (error) {
    console.error("updatePost error:", error);
    return res.status(500).json({ success: false, message: error.message });
  }
};

// GET /posts — Get all posts with filters + pagination
const getAllPosts = async (req, res) => {
  try {
    const {
      status,          // comma-separated: draft,published
      category,        // comma-separated category IDs
      image_generated, // comma-separated: yet_to_generate,generated
      date_from,       // ISO date string
      date_to,         // ISO date string
      page = 1,
      limit = 20,
    } = req.query;

    const filter = {};

    if (status) {
      filter.status = { $in: status.split(",").map((s) => s.trim()) };
    }

    if (category) {
      filter.category = { $in: category.split(",").map((c) => c.trim()) };
    }

    if (image_generated) {
      filter.image_generated = {
        $in: image_generated.split(",").map((s) => s.trim()),
      };
    }

    if (date_from || date_to) {
      filter.createdAt = {};
      if (date_from) filter.createdAt.$gte = new Date(date_from);
      if (date_to) filter.createdAt.$lte = new Date(date_to);
    }

    const skip = (parseInt(page) - 1) * parseInt(limit);
    const total = await Post.countDocuments(filter);

    const posts = await Post.find(filter)
      .populate("category", "name")
      .sort({ createdAt: -1 })
      .skip(skip)
      .limit(parseInt(limit));

    return res.status(200).json({
      success: true,
      data: posts,
      pagination: {
        total,
        page: parseInt(page),
        limit: parseInt(limit),
        totalPages: Math.ceil(total / parseInt(limit)),
      },
    });
  } catch (error) {
    console.error("getAllPosts error:", error);
    return res.status(500).json({ success: false, message: error.message });
  }
};

// GET /posts/:id — Get single post
const getOnePost = async (req, res) => {
  try {
    const post = await Post.findById(req.params.id).populate("category", "name");
    if (!post) {
      return res.status(404).json({ success: false, message: "Post not found" });
    }
    return res.status(200).json({ success: true, data: post });
  } catch (error) {
    console.error("getOnePost error:", error);
    return res.status(500).json({ success: false, message: error.message });
  }
};

// DELETE /posts/:id — Delete one post
const deleteOnePost = async (req, res) => {
  try {
    const post = await Post.findByIdAndDelete(req.params.id);
    if (!post) {
      return res.status(404).json({ success: false, message: "Post not found" });
    }

    categoryService.incrementTotalPins(post.category, -1).catch((err) =>
      console.error("incrementTotalPins failed:", err)
    );

    return res.status(200).json({ success: true, message: "Post deleted successfully" });
  } catch (error) {
    console.error("deleteOnePost error:", error);
    return res.status(500).json({ success: false, message: error.message });
  }
};

// DELETE /posts — Delete many posts by IDs array
const deleteManyPosts = async (req, res) => {
  try {
    const { ids } = req.body;

    if (!Array.isArray(ids) || ids.length === 0) {
      return res.status(400).json({
        success: false,
        message: "ids must be a non-empty array",
      });
    }

    const posts = await Post.find({ _id: { $in: ids } }, "category");
    const result = await Post.deleteMany({ _id: { $in: ids } });

    if (result.deletedCount > 0) {
      const categoryCount = {};
      for (const post of posts) {
        const catId = post.category.toString();
        categoryCount[catId] = (categoryCount[catId] || 0) + 1;
      }
      Promise.all(
        Object.entries(categoryCount).map(([catId, count]) =>
          categoryService.incrementTotalPins(catId, -count)
        )
      ).catch((err) => console.error("incrementTotalPins failed:", err));
    }

    return res.status(200).json({
      success: true,
      message: `${result.deletedCount} post(s) deleted successfully`,
      deletedCount: result.deletedCount,
    });
  } catch (error) {
    console.error("deleteManyPosts error:", error);
    return res.status(500).json({ success: false, message: error.message });
  }
};

module.exports = {
  createPost,
  updatePost,
  getAllPosts,
  getOnePost,
  deleteOnePost,
  deleteManyPosts,
};

const Category = require("../models/Category");
const categoryService = require("../services/category.service");

// POST /categories
const createCategory = async (req, res) => {
  try {
    const { name, coverImage, maxPins } = req.body;
    if (!name) {
      return res.status(400).json({ success: false, message: "Category name is required" });
    }

    const category = await categoryService.createCategory({ name, coverImage, maxPins });
    return res.status(201).json({
      success: true,
      message: "Category created successfully",
      data: category,
    });
  } catch (error) {
    if (error.code === 11000) {
      return res.status(409).json({ success: false, message: "Category already exists" });
    }
    return res.status(500).json({ success: false, message: error.message });
  }
};

// GET /categories
const getAllCategories = async (req, res) => {
  try {
    const categories = await Category.find().sort({ name: 1 });
    return res.status(200).json({ success: true, data: categories });
  } catch (error) {
    return res.status(500).json({ success: false, message: error.message });
  }
};

// DELETE /categories/:id
const deleteCategory = async (req, res) => {
  try {
    const category = await Category.findByIdAndDelete(req.params.id);
    if (!category) {
      return res.status(404).json({ success: false, message: "Category not found" });
    }
    return res.status(200).json({ success: true, message: "Category deleted successfully" });
  } catch (error) {
    return res.status(500).json({ success: false, message: error.message });
  }
};

// PUT /categories/:id
const updateCategory = async (req, res) => {
  try {
    const { name, coverImage, maxPins } = req.body;

    if (name === undefined && coverImage === undefined && maxPins === undefined) {
      return res.status(400).json({ success: false, message: "At least one field (name, coverImage, maxPins) is required" });
    }

    if (maxPins !== undefined && (!Number.isInteger(maxPins) || maxPins < 0)) {
      return res.status(400).json({ success: false, message: "maxPins must be a non-negative integer" });
    }

    const category = await categoryService.updateCategory(req.params.id, { name, coverImage, maxPins });
    if (!category) {
      return res.status(404).json({ success: false, message: "Category not found" });
    }
    return res.status(200).json({ success: true, data: category });
  } catch (error) {
    if (error.code === 11000) {
      return res.status(409).json({ success: false, message: "Category name already exists" });
    }
    return res.status(500).json({ success: false, message: error.message });
  }
};

module.exports = { createCategory, getAllCategories, deleteCategory, updateCategory };

const mongoose = require("mongoose");

const postSchema = new mongoose.Schema(
  {
    amazon_url: {
      type: String,
      required: [true, "Amazon URL is required"],
      trim: true,
    },

    affiliated_link: {
      type: String,
      trim: true,
      default: null,
    },

    image_urls: {
      type: [String],
      default: [],
    },

    category: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Category",
      required: [true, "Category is required"],
    },

    // AI Generated fields
    pinterest_title: {
      type: String,
      maxlength: [100, "Pinterest title cannot exceed 100 characters"],
      default: null,
    },

    pinterest_description: {
      type: String,
      maxlength: [500, "Pinterest description cannot exceed 500 characters"],
      default: null,
    },

    tags: {
      type: [String],
      validate: {
        validator: (arr) => arr.length <= 7,
        message: "Tags cannot exceed 7",
      },
      default: [],
    },

    overlay_text: {
      type: String,
      default: null,
    },

    // Status fields
    status: {
      type: String,
      enum: ["draft", "ready", "published"],
      default: "draft",
    },

    image_generated: {
      type: String,
      enum: ["yet_to_generate", "partially_generated", "generated"],
      default: "yet_to_generate",
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Post", postSchema);

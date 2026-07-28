const express = require("express");
const router = express.Router();
const {
  createPost,
  updatePost,
  getAllPosts,
  getOnePost,
  deleteOnePost,
  deleteManyPosts,
} = require("../controllers/post.controller");

router.post("/", createPost);
router.put("/:id", updatePost);
router.get("/", getAllPosts);
router.get("/:id", getOnePost);
router.delete("/bulk", deleteManyPosts); // must be before /:id
router.delete("/:id", deleteOnePost);

module.exports = router;

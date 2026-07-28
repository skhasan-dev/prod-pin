const Category = require("../models/Category");

const createCategory = async ({ name, coverImage, maxPins }) => {
  const data = { name: name.trim() };
  if (coverImage !== undefined) data.coverImage = coverImage;
  if (maxPins !== undefined) data.maxPins = maxPins;
  return Category.create(data);
};

const updateCategory = async (id, { name, coverImage, maxPins }) => {
  const update = {};
  if (name !== undefined) update.name = name.trim();
  if (coverImage !== undefined) update.coverImage = coverImage;
  if (maxPins !== undefined) update.maxPins = maxPins;

  return Category.findByIdAndUpdate(id, update, { new: true, runValidators: true });
};

const incrementTotalPins = (categoryId, amount) =>
  Category.findByIdAndUpdate(categoryId, { $inc: { totalPins: amount } });

module.exports = { createCategory, updateCategory, incrementTotalPins };

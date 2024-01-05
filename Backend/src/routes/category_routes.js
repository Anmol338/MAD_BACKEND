const CategoryRoute = require('express').Router();
const CategoryController = require('./../controllers/category_controller');

CategoryRoute.post("/", CategoryController.createCategory);
CategoryRoute.get("/", CategoryController.fetchAllCategories);
CategoryRoute.get("/:id", CategoryController.fetchCategoryById);

module.exports = CategoryRoute;
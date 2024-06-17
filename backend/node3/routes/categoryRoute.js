const express = require('express');
const router = express.Router();
const CategoryController = require('../controllers/CategoryController.js');
const upload = require('../utility/storage.js');
const { authenticateToken } = require('../middlewares/authMiddleware.js');

// get a category by ID
router.get('/:id',CategoryController.getCategoryById);
// get all category
router.get('/all',CategoryController.getAllCategoryRecursively);
// get all main category
router.get('/all/main',CategoryController.getMainParentCategories);
// get all category by id
router.get('/all/:id',CategoryController.getCategoryRecusivelyById);
// get all first children
router.get('/all/ch/:id', CategoryController.getFirstChildrenById);
// update category by ID
router.put('/:id',authenticateToken,CategoryController.updateCategory);
// create category
router.post('/',authenticateToken,CategoryController.createCategory);
router.post('/upload/', authenticateToken,upload.single('file'), CategoryController.UploadViaFile);
// delete category by ID
router.delete('/:id',authenticateToken,CategoryController.deleteCategory);
module.exports = router;

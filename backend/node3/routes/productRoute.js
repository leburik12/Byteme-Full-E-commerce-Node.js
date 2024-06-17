const express = require('express');
const router = express.Router();
const upload = require('../utility/storage.js');
const ProductController = require('../controllers/ProductController.js');
const { authenticateToken } = require('../middlewares/authMiddleware.js');

//   get all products
router.get('/',ProductController.getAllProduct);
//  product by name 
router.get('/name/:name',ProductController.getProductByName);
// get a product by ID
router.get('/:id',ProductController.getProductById);
// update product by ID
router.put('/:id',authenticateToken,ProductController.updateProduct);
// create product
router.post('/',authenticateToken,ProductController.createProduct);
router.post('/upload/', authenticateToken,upload.single('file'), ProductController.UploadViaFile);
// delete product by ID
router.delete('/:id',authenticateToken,ProductController.deleteProduct);
module.exports = router;

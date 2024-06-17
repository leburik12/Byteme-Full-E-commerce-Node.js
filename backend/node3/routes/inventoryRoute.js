const express = require('express');
const router = express.Router();
const upload = require('../utility/storage.js');
const InventoryController = require('../controllers/InventoryController.js');
const { authenticateToken } = require('../middlewares/authMiddleware.js');

//   get all products
router.get('/',InventoryController.getAllInventory);
//  product by name 
router.get('/name/:name',InventoryController.getInventoryById);
// get a inventory by ID
router.get('/:id', InventoryController.getInventoryById);
// update inventory 
router.put('/:id',authenticateToken,InventoryController.updateInventory);
// create inventory
router.post('/',authenticateToken,InventoryController.createInventory);
// delete inventory by ID
router.delete('/:id',authenticateToken,InventoryController.deleteInventory);
module.exports = router;

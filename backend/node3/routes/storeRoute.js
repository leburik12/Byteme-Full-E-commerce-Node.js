const express = require('express');
const router = express.Router();
const StoreController = require('../controllers/StoreController.js');
const uploadController = require('../utility/storage.js');
const upload = require('../utility/storage.js');

// get all stores
router.get('/',StoreController.getAllStore);

// to get a store by ID
router.get('/:id',StoreController.getStoreById);

// Route to update store by ID
router.post('/', StoreController.createStore);

// update store 
router.put('/:id',StoreController.updateStore);

// delete store 
router.delete('/:id',StoreController.deleteStore);

router.post('/upload/', upload.single('file'), StoreController.UploadViaFile);


// Route to login  
module.exports = router;
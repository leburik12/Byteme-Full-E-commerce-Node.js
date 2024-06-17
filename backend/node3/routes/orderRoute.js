const express = require('express');
const router = express.Router();
const upload = require('../utility/storage.js');
const OrderController = require('../controllers/OrderController.js');
const { authenticateToken } = require('../middlewares/authMiddleware.js');


module.exports = router;

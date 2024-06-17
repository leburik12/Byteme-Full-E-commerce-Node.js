const express = require('express');
const router = express.Router();
const roleController = require('../controllers/RoleController.js');
const { authenticateToken } = require('../middlewares/authMiddleware.js');

// Route to get all roles
router.get('/',authenticateToken,roleController.getAllRoles);
// Route to get a role by ID
router.get('/:id',authenticateToken,roleController.getRoleById);
// Route to update role by ID
router.put('/:id',authenticateToken,roleController.updateRole);
// Route to create role
router.post('/',authenticateToken,roleController.createRole);

// Route tp delete role by ID
router.delete('/:id',authenticateToken,roleController.deleteRole);
module.exports = router;

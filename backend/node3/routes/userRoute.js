const express = require('express');
const router = express.Router();
const userController = require('../controllers/UserController.js');
const {  verifyOTP } = require('../controllers/TwilioSmsService.js');

// get all users
router.get('/',userController.getAllUsers);

// to get a user by ID
router.get('/:id',userController.getUserById);

// Route to update user by ID
/* router.put('/:id', userController.updateUser); */
// create user
router.post('/', userController.createUser);

//router.post('/sendotp',sendOTP);
router.post('/verifyotp',verifyOTP);

// delete user by ID
router.delete('/:id',userController.deleteUser);

router.post('/login',userController.loginUser);
// Route to login  
module.exports = router;
const logger = require('../config/logger.js');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const authenticateToken = (req, res, next) => {
    // Extract the token from the Authorization header
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1]; // Separate 'Bearer' from token

    // check if token is not provided
    if (!token) {
        return res.status(401).json({success:false,message: 'Access denied.No token provided.'});
    }
    
    try {
        const decoded = jwt.verify(token,process.env.JWT_SECRET_KEY);
        req.userData = decoded;   // Attach user data to the request object
        next();  // Call the next middleware or route handler
    } catch (error) {
        logger.error(`Error invalid token \nMessage : ${error.mesage}\n name: ${error.name}`);
        return res.status(403).json({success:false, message: 'Invalid token'});
    }
}

const roleBaseControlAccessAdmin = (req, res, next) => {
    // Extract the token from the Authorization header
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1]; // Separate 'Bearer' from token

    // check if token is not provided
    if (!token) {
        return res.status(401).json({success:false,message: 'Access denied.No token provided.'});
    }
    
    try {
        const decoded = jwt.verify(token,process.env.JWT_SECRET_KEY);
        // check if the user role is Superadmin
        if (decoded.id_role !== 3) {
            return res.status(403).send({success: false,message: 'Access defined.'})
        }
        req.userData = decoded;   // Attach user data to the request object
        next();  // Call the next middleware or route handler
    } catch (error) {
        logger.error(`Error invalid token \nMessage : ${error.mesage}\n name: ${error.name}`);
        return res.status(403).json({success:false, message: 'Invalid token'});
    }
}

const roleBaseControlAccessMerchant = (req, res, next) => {
    // Extract the token from the Authorization header
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1]; // Separate 'Bearer' from token

    // check if token is not provided
    if (!token) {
        return res.status(401).json({success:false,message: 'Access denied.No token provided.'});
    }
    
    try {
        const decoded = jwt.verify(token,process.env.JWT_SECRET_KEY);
        // check if the user role is Superadmin
        if (decoded.id_role !== 2) {
            return res.status(403).send({success: false,message: 'Access defined.'})
        }
        req.userData = decoded;   // Attach user data to the request object
        next();  // Call the next middleware or route handler
    } catch (error) {
        logger.error(`Error invalid token \nMessage : ${error.mesage}\n name: ${error.name}`);
        return res.status(403).json({success:false, message: 'Invalid token'});
    }
}

const roleBaseControlAccessSuperAdmin = (req, res, next) => {
    // Extract the token from the Authorization header
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1]; // Separate 'Bearer' from token

    // check if token is not provided
    if (!token) {
        return res.status(401).json({success:false,message: 'Access denied.No token provided.'});
    }
    
    try {
        const decoded = jwt.verify(token,process.env.JWT_SECRET_KEY);
        // check if the user role is admin
        if (decoded.id_role !== 4) {
            return res.status(403).send({success: false,message: 'Access defined.'})
        }
        req.userData = decoded;   // Attach user data to the request object
        next();  // Call the next middleware or route handler
    } catch (error) {
        logger.error(`Error invalid token \nMessage : ${error.mesage}\n name: ${error.name}`);
        return res.status(403).json({success:false, message: 'Invalid token'});
    }
}


module.exports = { authenticateToken,roleBaseControlAccessAdmin,
    roleBaseControlAccessSuperAdmin,roleBaseControlAccessMerchant };
const OrderModel = require('../models/OrderModel.js');
const logger = require('../config/logger.js');
const RegexpUtils = require('../utility/regexUtils.js');
const {idRegexp,isRegexpValid,isValidName} = require('../utility/regexUtils.js');
const fs = require('fs');
const {checkColumnExists} = require('../utility/dbUtils.js');

const OrderController = {

    getAllOrder : async (req,res,next) => {
        try {
            const stores = await OrderModel.getAllProduct();
            if (!stores) {
                logger.error(`internal sql server error in getting all stores`);
                res.status(500).json({message: 'internal server error'});
            } else {
                res.status(200).json(stores);
            } 
        } catch (error) {
          logger.error(`Error getting Product: ${error.message}`);
          next(error);
        }
    },

    getOrderById : async (req,res,next) => {
       const { id } = req.params;

       // check if the id parameter is a valid
       if (!isRegexpValid(idRegexp,id)) {
        logger.error(`Invalid Product id format: ${id}`);
        return res.status(400).json({message: 'Invalid Product ID format'});
       }

        try {
            const store = await OrderModel.getStoreById(id);
            if (!store) {
                logger.error(`Product not found by this id : ${id}`);
                return res.status(404).json({success:false,message: 'Product not found'});
            } else {
              logger.info(`Product found by id : ${id}`);
            res.status(200).json(role);
        }
        } catch (error) {
            logger.error(`Error getting Product by id ${error.message}`);
            next(error);
        }
    },

     getOrderByName : async (req,res,next) => {
       const { name } = req.params;

       // Get pagination parameters from query string (adjust as needed)
       const page = parseInt(req.query.page) || 1; // Current page (default 1)
       const limit = parseInt(req.query.limit) || 10;   // Items per page (default 10)
       const offset = (page - 1) * limit;   // Offset for specific page

       // check if the id parameter is a valid
       if (name.length === 0) {
        logger.error(`Invalid Product name : ${name}`);
        return res.status(400).json({message: 'Invalid Product name'});
       }

        try {
            const products = await OrderModel.getProductByName(name,limit,offset);
            if (!products) {
                logger.error(`Product not found by this name : ${name}`);
                return res.status(204).json({success:false,message: 'Product not found'});
            } else {
              logger.info(`Product found by name : ${name}`);
            res.status(200).json(products);
        }
        } catch (error) {
            logger.error(`Error getting Product by id ${error.message}`);
            next(error);
        }
    },

    createOrder : async (req,res,next) => {
        const { name,ptype,category_id } = req.body;

        try {
            const user_id =  req.userData.id;
            const product = await OrderModel.createOrder(name,ptype,category,user_id);
            if (product.success !== true) {
             return res.status(500).json({
                success: false,
                message: 'Internal error'
                }) 
            } else {
             logger.error(`internal server error in create order`);
             res.status(500).json({message: 'Internal server error'});
            }
         } catch (error) {
            logger.error(`Error in create order ${error.message}`);
            next(error);
          }
    },


    CancelOrder : async (req,res,next) => {
       const {id} = req.params;

       // check if the id parameter is a valid
       if (!isRegexpValid(RegexpUtils.idRegexp,id)) {
        logger.error(`Invalid order id format: ${id}`);
        return res.status(400).json({message: 'Invalid order ID format'});
       } 

       try {
        const canceledOrder = await OrderModel.deleteOrder(id);
        if (canceledOrder.success !== true) {
            return res.status(500).json({
                success: false,
                message: 'Internal error'
            }) 
        } else {
             logger.error(`internal server error in canceling order`);
             res.status(500).json({message: 'Internal server error'});
        }
       } catch (error) {
        logger.error(`Error canceling order with id ${id} : ${error.message}`)
          next(error);
       }
    },

}

module.exports = OrderController;
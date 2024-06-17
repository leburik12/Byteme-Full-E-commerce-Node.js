const RestaurantModel = require('../models/RestaurantModel.js');
const StoreModel = require('../models/StoreModel.js');
const logger = require('../config/logger.js');
const RegexpUtils = require('../utility/regexUtils.js');
const {idRegexp,isRegexpValid,isValidName} = require('../utility/regexUtils.js');
const fs = require('fs');
const {checkColumnExists} = require('../utility/dbUtils.js');

const RestaurantController = {

    getAllRestaurant : async (req,res,next) => {
        try {
            const result = await RestaurantModel.getAllRestaurant();
            if (!result) {
                logger.error(`internal sql server error in getting all Restaurant`);
                res.status(500).json({message: 'internal server error'});
            } else {
                res.status(200).json(result);
            } 
        } catch (error) {
          logger.error(`Error getting Restaurant: ${error.message}`);
          next(error);
        }
    },

    getRestaurantById : async (req,res,next) => {
       const { id } = req.params;

       // check if the id parameter is a valid
       if (!isRegexpValid(idRegexp,id)) {
        logger.error(`Invalid Restaurant id format: ${id}`);
        return res.status(400).json({message: 'Invalid Restaurant ID format'});
       }

        try {
            const store = await RestaurantModel.getRestaurantById(id);
            if (!store) {
                logger.error(`Restaurant not found by this id : ${id}`);
                return res.status(404).json({success:false,message: 'Restaurant not found'});
            } else {
              logger.info(`Restaurant found by id : ${id}`);
            res.status(200).json(role);
          }
        } catch (error) {
            logger.error(`Error getting Restaurant by id ${error.message}`);
            next(error);
        }
    },

     getRestaurantByName : async (req,res,next) => {
       const { name } = req.params;

       // Get pagination parameters from query string (adjust as needed)
       const page = parseInt(req.query.page) || 1; // Current page (default 1)
       const limit = parseInt(req.query.limit) || 10;   // Items per page (default 10)
       const offset = (page - 1) * limit;   // Offset for specific page

       // check if the name parameter is a valid
       if (name.length === 0) {
        logger.error(`Invalid Restaurant name : ${name}`);
        return res.status(400).json({message: 'Invalid Restaurant name'});
       }

        try {
            const result = await RestaurantModel.getRestaurantByName(name,limit,offset);
            if (!result) {
                logger.error(`Restaurant not found by this name : ${name}`);
                return res.status(204).json({success:false,message: 'Restaurant not found'});
            } else {
              logger.info(`Restaurant found by name : ${name}`);
            res.status(200).json(result);
        }
        } catch (error) {
            logger.error(`Error getting Restaurant by name ${error.message}`);
            next(error);
        }
    },

    createRestaurant : async (req,res,next) => {
          const { 
            name,
            description,
            image_path,
            branchs,
            approved,
            postal_code,
            store_choice,
            id_cuisine_type,
            seating_capacity,
            michelin_stars,
            ambiance } = req.body;
        
        // validate request body
        if (!name || !description || !image_path || !branchs || !approved 
            || !postal_code || store_choice || id_cuisine_type || seating_capacity || michelin_stars || ambiance) {
            logger.error(`internal server error in create restaurant.`);
            return res.status(400).json({ error: 'All fields are required to create a restaurant' });
        }    

        try {
            const user_id =  req.userData.id;
            const product = await ProductModel.createStore(name,ptype,category,user_id);
            if (product.success !== true) {
             return res.status(500).json({
                success: false,
                message: 'Internal error'
                }) 
            } else {
             logger.error(`internal server error in create product`);
             res.status(500).json({message: 'Internal server error'});
            }
         } catch (error) {
            logger.error(`Error in create product ${error.message}`);
            next(error);
          }
    },

    updateRestaurant : async (req,res,next) => {
       const {id} = req.params;
       const { name,ptype,category_id } = req.body;

        // check if Product name valid
        if (!isRegexpValid(isValidName,name)) {
            logger.error(`Invalid Product name format : ${name}`);
            return res.status(400).json({
                success: false,
                message: `Invalid store name format. ${name}`
           })
          }
          
        // check if ptype and category is valid
        if ( typeof ptype !== number || typeof category !== number ) {
            logger.error(`Invalid store type value : ${store_type}`);
            return res.status(400).json({
                success: false,
                message: `Invalid store type value. ${store_type}`
           }) 
        }

        // check for the validity of category
        const categoryExists = await checkForeignKeysExist(category_id, 'lukup_category');
        if ( categoryExists !== true ) {
            logger.error(`Invalid category type`);
            return res.status(400).json({
                    success: false,
                    message: `Invalid category type.`
                }) 
        }

       try {
           const product = await ProductModel.updateProduct(name,ptype,category_id);
            if (product.success !== true) {
             return res.status(500).json({
                success: false,
                message: 'Internal error'
                }) 
            } else {
             logger.error(`internal server error in create product`);
             res.status(500).json({message: 'Internal server error'});
            }
       } catch (error) {
        logger.error(`Error updating product with id ${id} : ${error.message}`);
        next(error);
       }
    },

    deleteRestaurant : async (req,res,next) => {
       const {id} = req.params;

       // check if the id parameter is a valid
       if (!isRegexpValid(RegexpUtils.idRegexp,id)) {
        logger.error(`Invalid product id format: ${id}`);
        return res.status(400).json({message: 'Invalid product ID format'});
       } 

       try {
        const productDeleted = await ProductModel.deleteStore(id);
        if (productDeleted.success !== true) {
            return res.status(500).json({
                success: false,
                message: 'Internal error'
            }) 
        } else {
             logger.error(`internal server error in deleting product`);
             res.status(500).json({message: 'Internal server error'});
        }
       } catch (error) {
        logger.error(`Error deleting product with id ${id} : ${error.message}`)
          next(error);
       }
    },
}

module.exports = RestaurantController;
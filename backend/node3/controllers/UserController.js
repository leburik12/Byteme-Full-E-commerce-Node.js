const bcrypt = require('bcrypt');
const { redisClient } =  require('../config/config.js');
const keyGenerator = require('../utility/redis_key_generator.js');
const OrderModel = require('../models/OrderModel.js');
const logger = require('../config/logger.js');
const jwt = require('jsonwebtoken');
const {emailRegexp,idRegexp, isRegexpValid,userNameRegexp,phoneNumRegexp,passwordRegexp} = require('../utility/regexUtils.js');
const { checkColumnExists } = require('../utility/dbUtils.js');
const {cacheUnAuthUser,scanHash,saveUserAddress } = require('../cache/cacheData.js');
const { generateSecureKey } = require('../config/secretKey.js');
require('dotenv').config();

const {checkColumnExists} = require('../utility/dbUtils.js');

const OrderController = {

    getAllOrder : async (req,res,next) => {
         try {
            const results = await OrderModel.getAllOrder();
            if (results.success === false) {
                logger.error(`internal sql server error in getting all inventories`);
                res.status(500).json({message: 'internal server error'});
            } 
            logger.info('Successfully returned inventories');
            res.status(200).json({ success: true,message: results });
         } catch (error) {
           logger.error(`Error getting inventories : ${error.message}`);
           next(error);
         }
    },

    getOrderById : async (req,res,next) => {
       const { id } = req.params;   

       // check if the id parameter is a valid
       if (!isRegexpValid(idRegexp,id)) {
        logger.error(`Invalid store id format: ${id}`);
        return res.status(400).json({message: 'Invalid store ID format'});
       }

        try {
            const store = await OrderModel.getOrderById(id);
            if (!store) {
                logger.error(`store not found by this id : ${id}`);
                return res.status(404).json({success:false,message: 'store not found'});
            } else {
              logger.info(`store found by id : ${id}`);
            res.status(200).json(role);
        }
        } catch (error) {
            logger.error(`Error getting store by id ${error.message}`);
            next(error);
            //res.status(500).send({message: 'Internal server error'});
        }
    },

    getOrderByUserId : async (req,res,next) => {
       const { id } = req.params;   

       // check if the id parameter is a valid
       if (!isRegexpValid(idRegexp,id)) {
        logger.error(`Invalid order id format: ${id}`);
        return res.status(400).json({message: 'Invalid order ID format'});
       }

        try {
            const store = await OrderModel.getOrderByUserId(id);
            if (!store) {
                logger.error(`Order not found by this id : ${id}`);
                return res.status(404).json({success:false,message: 'Order not found'});
            } else {
              logger.info(`Order found by id : ${id}`);
            res.status(200).json(role);
        }
        } catch (error) {
            logger.error(`Error getting Order by id ${error.message}`);
            next(error);
        }
    },

    createOrder : async (req,res,next) => {
          const { name,description,branchs=1,store_type } = req.body;

          // check if store name valid
          if (!isRegexpValid(isValidName,name)) {
            logger.error(`Invalid store nmae format : ${name}`);
            return res.status(400).json({
                success: false,
                message: `Invalid store name format. ${name}`
           })
          }
          // check if branchs name valid
          if (branchs = 0 || branchs < 0 ) {
            logger.error(`Invalid store branch value : ${branchs}`);
            return res.status(400).json({
                success: false,
                message: `Invalid store branch value. ${branchs}`
           }) 
          }

          // check if branchs name valid
          if ( typeof store_type !== number || store_type < 1 || store_type > 10 ) {
            logger.error(`Invalid store type value : ${store_type}`);
            return res.status(400).json({
                success: false,
                message: `Invalid store type value. ${store_type}`
           }) 
          }
        
          try {
            const user_id =  req.userData.id;
            const store = await OrderModel.createStore(name,description,brand_name,store_type,user_id);
            if (store.success !== true) {
             return res.status(500).json({
                success: false,
                message: 'Internal error'
           }) 
            } else {
             logger.error(`internal server error in create store`);
             res.status(500).json({message: 'Internal server error'});
            }
          } catch (error) {
            logger.error(`Error in create store ${error.message}`);
            //res.status(500).send({message: 'Internal server error'});
            next(error);
          }
    },

    updateOrder : async (req,res,next) => {
       const {id} = req.params;

       // check if the id parameter is a valid
       if (!RegexpUtils.isRegexpValid(RegexpUtils.idRegexp,id)) {
        logger.error(`Invalid store id format: ${id}`);
        return res.status(400).json({message: 'Invalid store ID format'});
       }
       const { role_name, description, isactive } = req.body;

      // check if isactive value is valid
          if (!RegexpUtils.isRegexpValid(RegexpUtils.isActiveRegexp,isactive)) {
            logger.error(`Invalid store id format: ${id}`);
            return res.status(400).json({message: 'Invalid store ID format'});
          }

        // check if rolename value is valid
        if (!RegexpUtils.isRegexpValid(RegexpUtils.rolenameDescriptionRegexp,role_name)) {
          logger.error(`Invalid rolename format : ${role_name}`);
            return res.status(400).json({
              message: 'Invalid role rolename format',
              body: {role_name: `${role_name}`}
              });
         }

        // check if description value is valid
        if (!RegexpUtils.isRegexpValid(RegexpUtils.rolenameDescriptionRegexp,role_name)) {
          logger.error(`Invalid rolename format : ${role_name}`);
          logger.error(`Invalid description format : ${description}`);
          return res.status(400).json({
              message: 'Invalid description format', 
              body : {description : `${description}`}});
         } 
       
       try {
           const updatedRole = await OrderModel.updateCategory(id,role_name,description,isactive);
           if (updatedRole.rowCount !== 0) {
            res.status(200).json(updatedRole);
           } else {
            logger.error(`internal server error in update role`);
            res.status(500).json({message: 'Internal server error'});
           }
       } catch (error) {
        logger.error(`Error updating role with id ${id} : ${error.message}`);
        next(error);
       }
    },

    deleteOrder : async (req,res,next) => {
       const {id} = req.params;

       // check if the id parameter is a valid
       if (!isRegexpValid(RegexpUtils.idRegexp,id)) {
        logger.error(`Invalid role id format: ${id}`);
        return res.status(400).json({message: 'Invalid role ID format'});
       } 
       try {
        const deletedRole = await OrderModel.deleteCategory(id);
        if (deletedRole.rowCount !== 0) {
            res.status(200).json(deletedRole);
        } else {
            logger.error(`internal server error in deleting role by id`);
            res.status(500).json({message: 'Internal server error'});
        }
       } catch (error) {
        logger.error(`Error deleting role with id ${id} : ${error.message}`)
          next(error);
        //res.status(500).json({message: 'Internal server error'});
       }
    },
}

module.exports = InventoryController;

module.exports = UserControler;


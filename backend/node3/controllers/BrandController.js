const CategoryModel = require('../models/LukupCategoryModel.js');
const logger = require('../config/logger.js');
const RegexpUtils = require('../utility/regexUtils.js');
const {idRegexp,isRegexpValid,isValidName} = require('../utility/regexUtils.js');
const fs = require('fs');

const {checkColumnExists} = require('../utility/dbUtils.js');

const BrandController = {

    getAllCategoryRecursively : async (req,res,next) => {
         try {
            const recursiveCategory = await CategoryModel.getAllCategoryRecusively();
            if (recursiveCategory.success === false) {
                logger.error(`internal sql server error in getting all categories`);
                res.status(500).json({message: 'internal server error'});
            } 
            logger.info('Successfully returned recursive categories');
            res.status(200).json({success: true,message: recursiveCategory});
         } catch (error) {
           logger.error(`Error getting roles: ${error.message}`);
           next(error);
         }
    },

    getCategoryRecusivelyById : async (req,res,next) => {
         try {
            const recursiveCategory = await CategoryModel.getCategoryRecusivelyById();
            if (recursiveCategory.success === false) {
                logger.error(`internal sql server error in getting all categories by id`);
                return res.status(500).json({message: 'internal server error'});
            } 
            logger.info('Successfully returned recursive categories by id');
            return res.status(200).json({success: true,message: recursiveCategory});
         } catch (error) {
           logger.error(`Error getting categories: ${error.message}`);
           next(error);
         }
    },

    getFirstChildrenById : async (req,res,next) => {
      const { id } = req.params;
      logger.info('------------------------------------------------');

        try {
            const results = await CategoryModel.getFirstChildrenById(id);
            if (results.success === false && results.errorCode === 0) {
               logger.error(`Empty result from category first children by id`);
                return res.status(204).json({message: 'Empty result'});
            }
            if (results.success === false) {
                logger.error(`internal sql server error in getting all category first children by id`);
                return res.status(500).json({message: 'internal server error'});
            } 
            logger.info('Successfully returned category first children by id');
            return res.status(200).json({success: true,message: results});
         } catch (error) {
           logger.error(`Error getting category first children : ${error.message}`);
           next(error);
         }
    },

    getMainParentCategories : async (req,res,next) => {

        try {
            const results = await CategoryModel.getMainParentCategories();
            if (results.success === false) {
                logger.error(`internal sql server error in getting all main parent category by id`);
                return res.status(500).json({message: 'internal server error'});
            } 
            logger.info('Successfully returned main parent category by id');
            return res.status(200).json({success: true,message: results});
         } catch (error) {
           logger.error(`Error getting main parent category : ${error.message}`);
           next(error);
         }
    },

    getAllCategory : async (req,res,next) => {
        try {
            const stores = await CategoryModel.getAllCategory();
            if (!stores) {
                logger.error(`internal sql server error in getting all stores`);
                res.status(500).json({message: 'internal server error'});
            } 
               return res.status(200).json(stores);
        } catch (error) {
          logger.error(`Error getting roles: ${error.message}`);
          next(error);
        }
    },

    getCategoryById : async (req,res,next) => {
       const { id } = req.params;

       // check if the id parameter is a valid
       if (!isRegexpValid(idRegexp,id)) {
        logger.error(`Invalid store id format: ${id}`);
        return res.status(400).json({message: 'Invalid store ID format'});
       }

        try {
            const store = await CategoryModel.getCategoryById(id);
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

    createCategory : async (req,res,next) => {
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
            const store = await CategoryModel.createStore(name,description,brand_name,store_type,user_id);
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

    updateCategory : async (req,res,next) => {
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
           const updatedRole = await CategoryModel.updateCategory(id,role_name,description,isactive);
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

    deleteCategory : async (req,res,next) => {
       const {id} = req.params;

       // check if the id parameter is a valid
       if (!isRegexpValid(RegexpUtils.idRegexp,id)) {
        logger.error(`Invalid role id format: ${id}`);
        return res.status(400).json({message: 'Invalid role ID format'});
       } 
       try {
        const deletedRole = await CategoryModel.deleteCategory(id);
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

module.exports = BrandController;
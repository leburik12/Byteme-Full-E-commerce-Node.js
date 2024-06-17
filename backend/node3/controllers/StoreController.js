const StoreModel = require('../models/StoreModel.js');
const logger = require('../config/logger.js');
const RegexpUtils = require('../utility/regexUtils.js');
const {idRegexp,isRegexpValid,isValidName} = require('../utility/regexUtils.js');
const fs = require('fs');

const {checkColumnExists} = require('../utility/dbUtils.js');

const StoreController = {

    getAllStore : async (req,res,next) => {
        try {
            const stores = await StoreModel.getAllStores();
            if (!stores) {
                logger.error(`internal sql server error in getting all stores`);
                res.status(500).json({message: 'internal server error'});
            } else {
                res.status(200).json(stores);
            } 
        } catch (error) {
          logger.error(`Error getting roles: ${error.message}`);
          next(error);
        }
    },

    getStoreById : async (req,res,next) => {
       const { id } = req.params;

       // check if the id parameter is a valid
       if (!isRegexpValid(idRegexp,id)) {
        logger.error(`Invalid store id format: ${id}`);
        return res.status(400).json({message: 'Invalid store ID format'});
       }

        try {
            const store = await StoreModel.getStoreById(id);
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

    createStore : async (req,res,next) => {
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
            const store = await StoreModel.createStore(name,description,brand_name,store_type,user_id);
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

    updateStore : async (req,res,next) => {
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
           const updatedRole = await StoreModel.updateStore(id,role_name,description,isactive);
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

    deleteStore : async (req,res,next) => {
       const {id} = req.params;

       // check if the id parameter is a valid
       if (!isRegexpValid(RegexpUtils.idRegexp,id)) {
        logger.error(`Invalid role id format: ${id}`);
        return res.status(400).json({message: 'Invalid role ID format'});
       } 
       try {
        const deletedRole = await StoreModel.deleteStore(id);
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

    UploadViaFile : async (req,res,next) => {

        if (!req.file) {
            logger.error('No file format supplied');
            return res.status(400).send({
                success:false,
                message: 'No file supplied'
            });
        }

      const { file_type } = req.body;
      const filepath = req.file.path
      const results = [];

      fs.createReadStream(filepath)
        .pipe(csv())
        .on('data', (data) => results.push(data))
        .on('end', async () => {
            try {
            const user_id =  req.userData.id;
            let counter = 0;
              for (const row of results) {
                try {              
                    const store = await StoreModel.createStore(row.name,row.description,row.brand_name,row.store_type,user_id);
                    if (store.success !== true) {
                        return res.status(500).json({
                            success: false,
                            message: 'Internal error'
                        }) 
                   } 
                   ++counter;
                }
                 catch (error) {
                    logger.error(`Error in create store ${error.message}`);
                    next(error);
                }
              }
            logger.info(`Successfully uploaded products from file. ${counter}`);
            res.status(200).json({success:true,message: 'Internal server error'})
            } catch (error) {
                logger.error(``);
            }
        })
      
       const {id} = req.params;

       // check if the id parameter is a valid
       if (!isRegexpValid(RegexpUtils.idRegexp,id)) {
        logger.error(`Invalid role id format: ${id}`);
        return res.status(400).json({message: 'Invalid role ID format'});
       } 
       try {
        const deletedRole = await StoreModel.deleteStore(id);
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

module.exports = StoreController;
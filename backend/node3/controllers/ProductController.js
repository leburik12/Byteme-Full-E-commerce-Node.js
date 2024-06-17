const ProductModel = require('../models/ProductModel.js');
const logger = require('../config/logger.js');
const RegexpUtils = require('../utility/regexUtils.js');
const {idRegexp,isRegexpValid,isValidName} = require('../utility/regexUtils.js');
const fs = require('fs');
const {checkColumnExists} = require('../utility/dbUtils.js');

const ProductController = {

    getAllProduct : async (req,res,next) => {
        try {
            const stores = await ProductModel.getAllProduct();
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

    getProductById : async (req,res,next) => {
       const { id } = req.params;

       // check if the id parameter is a valid
       if (!isRegexpValid(idRegexp,id)) {
        logger.error(`Invalid Product id format: ${id}`);
        return res.status(400).json({message: 'Invalid Product ID format'});
       }

        try {
            const store = await ProductModel.getStoreById(id);
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

     getProductByName : async (req,res,next) => {
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
            const products = await ProductModel.getProductByName(name,limit,offset);
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

    createProduct : async (req,res,next) => {
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

    updateProduct : async (req,res,next) => {
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

    deleteProduct : async (req,res,next) => {
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
                    const product = await ProductModel.createStore(row.name,row.ptype,row.category,user_id);
                    if (product.success !== true) {
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
        .on('error', (err) => {
            logger.info(`Error reading file:`,err.message);
            res.status(500).json({success:false,message: 'Error while reading file'})
        })

    },
}

module.exports = ProductController;
const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');

const ProductModel = {

    getAllProduct: async (limit, offset) => {
        const query = {
            text: 'SELECT * FROM product ORDER BY id ASC LIMIT $2 OFFSET $3',
        };
    try {  
        const result = await pool.query(query);
        if (result.rows.length === 0) {
           return {
                success: false
               }
        }
         return {
                success: true,
                message: result.rows
               }
      } catch (error) {
        logger.error(`Error fetching product: ${error.message}`);
        throw error;
      }  
    },

    getProductByName: async (product_name,limit,offset) => {
      const query = {
        text: "SELECT * FROM product WHERE name LIKE $1 || '%' ORDER BY id ASC LIMIT $2 OFFSET $3",
        values: [product_name,limit,offset]
      };
      try {
            const result = await pool.query(query);
           if (result.rows.length === 0) {
            logger.error(`No product found`);
             return {
                success: false
               }
           } 
           logger.info(`product found by name ${product_name}`);
           return {
                success: true,
                message: result.rows
               }
      } catch (error) {
        logger.error(`Error getting product by id : ${error.message}`);
        throw error;
      }
    },

    getProductById: async (id) => {
        const query = {
            text: 'SELECT * FROM product where id = $1',
            value: [id],
         };
        try {
           const result = await pool.query(query);
           if (!result.rows || result.rows.length === 0) {
            logger.error(`Error fetching product by ID : ${error.message}`);
             return {
                success: false
               }
           } 
            return {
                success: true,
                message: result.rows[0]
               }
        } catch (error) {
             logger.error(`Error getting product by id : ${error.message}`);
             throw error;
        }
    },

    createProduct : async (name,ptype,category) => {
        if (!category){
            category=null;
        }
        const query = {
            text: 'INSERT INTO product(name,ptype,category) VALUES ($1,$2,$3) RETURNING *',
            values: [name,ptype,category],
         };
    	try {
           const result = await pool.query(query);
           if (result.rowCount === 0) {
            logger.error('No rows are inserted');
            return {
                success: false
               }
           } else {
            logger.info(`product created successfully: ${result.rows}`);
            return {
                success: true,
                message: result.rows[0]
               }
           }
	  } catch (error) { 
        logger.error(`Error in creating product: ${error.message}`);
        throw error;
      }
    },

    updateProduct : async (name,ptype,category) => {
        const query = {
            text:   'UPDATE product set name = $1,ptype = $2,category = $3 WHERE id = $4 RETURNING *',
            values: [name,ptype,category],
        };  
        try {
        const result = await pool.query(query);
        if (!(result.rows.length > 0)) {
            logger.error(`Error in creating product`);
            return {
                success: false
               }
        } else {
            const updatedProduct = result.rows[0];
            logger.info(`product updated successfully: ${result}`);
            return {
                success: true,
                message: updatedProduct.rows[0]
               }
        }
       } catch (error) {   
           logger.error(`Error update product with given ID: ${id}`);
           throw error;
       }
    },

    deleteProduct : async (id) => {
      const query = {
        text:   'DELETE FROM product WHERE id = $1 RETURNING *',
        values: [id],
      };

      try {
          const result = await pool.query(query);
          if (result.rowCount === 0) {
             logger.error(`product with id - ${id} not found`);
              return {
                success: false
               }
          } else{
          logger.info(`Successfully deleted product with id : ${id}`);
           return {
                success: true,
                message: result.rows[0]
               }
        }
      } catch (error) {
        logger.error(`Error in deleting product: ${error.message}`);
        throw error;
      }
    },       
}
module.exports = ProductModel;

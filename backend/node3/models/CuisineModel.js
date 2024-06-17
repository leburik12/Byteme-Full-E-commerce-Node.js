const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');

const CuisineModel = {

    getAllCuisine : async () => {
        const query = {
            text: 'SELECT * FROM cuisine_type',
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
        logger.error(`Error fetching cuisine_type: ${error.message}`);
        throw error;
      }  
    },

    getCuisineById: async (id) => {
        const query = {
            text: 'SELECT * FROM cuisine_type where id = $1',
            value: [id],
         };
        try {
           const result = await pool.query(query);
           if (!result.rows || result.rows.length === 0) {
            logger.error(`Error fetching cuisine_type by ID : ${error.message}`);
             return {
                success: false
               }
           } 
            return {
                success: true,
                message: result.rows[0]
               }
        } catch (error) {
             logger.error(`Error getting cuisine_type by id : ${error.message}`);
             throw error;
        }
    },

    getCuisineByName: async (name,limit,offset) => {
      const query = {
        text: "SELECT * FROM cuisine_type WHERE ctname LIKE $1 || '%' ORDER BY id ASC LIMIT $2 OFFSET $3",
        values: [name,limit,offset]
      };
      try {
            const result = await pool.query(query);
           if (result.rows.length === 0) {
            logger.error(`No cuisine found`);
             return {
                success: false
               }
           } 
           logger.info(`cuisine found by name ${name}`);
           return {
                success: true,
                message: result.rows
               }
      } catch (error) {
        logger.error(`Error getting cuisine by id : ${error.message}`);
        throw error;
      }
    },

    createCuisine : async (name) => {
        const query = {
            text: 'INSERT INTO cuisine_type(ctname) VALUES ($1) RETURNING *',
            values: [name],
         };
    	try {
           const result = await pool.query(query);
           if (result.rowCount === 0) {
            logger.error('No Cuisine are inserted');
            return {
                success: false
               }
           } else {
            logger.info(`Cuisine created successfully: ${result.rows}`);
            return {
                success: true,
                message: result.rows[0]
               }
           }
	  } catch (error) { 
        logger.error(`Error in creating Cuisine: ${error.message}`);
        throw error;
      }
    },

    updateCuisine : async (name) => {
        const query = {
            text:   'UPDATE cuisine_type set ctname = $1 WHERE id = $4 RETURNING *',
            values: [name],
        };  
        try {
        const result = await pool.query(query);
        if (!(result.rows.length > 0)) {
            logger.error(`Error in creating Cuisine`);
            return {
                success: false
               }
        } else {
            const updatedRole = result.rows[0];
            logger.info(`Cuisine updated successfully: ${result}`);
            return {
                success: true,
                message: updatedRole.rows[0]
               }
        }
       } catch (error) {   
           logger.error(`Error update Cuisine with given ID: ${id}`);
           throw error;
       }
    },

    deleteCuisine : async (id) => {
      const query = {
        text:   'DELETE FROM cuisine WHERE id = $1 RETURNING *',
        values: [id],
      };

      try {
          const result = await pool.query(query);
          if (result.rowCount === 0) {
             logger.error(`cuisine with id - ${id} not found`);
              return {
                success: false
               }
          } else{
          logger.info(`Successfully deleted cuisine with id : ${id}`);
           return {
                success: true,
                message: result.rows[0]
               }
        }
      } catch (error) {
        logger.error(`Error in deleting cuisine: ${error.message}`);
        throw error;
      }
    },       
}
module.exports = CuisineModel;

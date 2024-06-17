const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');

const CountryModel = {

    getAllCountry: async (limit,offset) => {
        const query = {
            text: 'SELECT * FROM country ORDER BY id ASC LIMIT $1 OFFSET $2',
            values: [limit,offset]
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
        logger.error(`Error fetching country: ${error.message}`);
        throw error;
      }  
    },

    getCountryById: async (id) => {
        const query = {
            text: 'SELECT * FROM country where id = $1',
            value: [id],
         };
        try {
           const result = await pool.query(query);
           if (!result.rows || result.rows.length === 0) {
            logger.error(`Error fetching country by ID : ${error.message}`);
             return {
                success: false
               }
           } 
            return {
                success: true,
                message: result.rows[0]
               }
        } catch (error) {
             logger.error(`Error getting country by id : ${error.message}`);
             throw error;
        }
    },

    createCountry: async (country_name,country_image_url, country_phone_code) => {
        const query = {
            text: 'INSERT INTO country(country_name,country_image_url,country_phone_code) VALUES ($1,$2,$3) RETURNING *',
            values: [country_name,country_image_url,country_phone_code],
         };
    	try {
           const result = await pool.query(query);
           if (result.rowCount === 0) {
            logger.error('No rows are inserted');
            return {
                success: false
               }
           } else {
            logger.info(`Country created successfully: ${result.rows}`);
            return {
                success: true,
                message: result.rows[0]
               }
           }
	  } catch (error) { 
        logger.error(`Error in creating Country: ${error.message}`);
        throw error;
      }
    },

    updateCountry: async (country_name,country_image_url, country_phone_code) => {
        const query = {
            text:   'UPDATE country set country_name = $1,country_image_url = $2,country_phone_code = $3 WHERE id = $4 RETURNING *',
            values: [country_name,country_image_url,country_phone_code],
        };  
        try {
        const result = await pool.query(query);
        if (!(result.rows.length > 0)) {
            logger.error(`Error in creating country`);
            return {
                success: false
               }
        } else {
            const updatedRole = result.rows[0];
            logger.info(`Country updated successfully: ${result}`);
            return {
                success: true,
                message: updatedRole.rows[0]
               }
        }
       } catch (error) {   
           logger.error(`Error update role with given ID: ${id}`);
           throw error;
       }
    },

    deleteCountry: async (id) => {
      const query = {
        text:   'DELETE FROM roles WHERE id = $1 RETURNING *',
        values: [id],
      };

      try {
          const result = await pool.query(query);
          if (result.rowCount === 0) {
             logger.error(`Country with id - ${id} not found`);
              return {
                success: false
               }
          } else{
          logger.info(`Successfully deleted country with id : ${id}`);
           return {
                success: true,
                message: result.rows[0]
               }
        }
      } catch (error) {
        logger.error(`Error in deleting country: ${error.message}`);
        throw error;
      }
    },       
}
module.exports = RoleModel;

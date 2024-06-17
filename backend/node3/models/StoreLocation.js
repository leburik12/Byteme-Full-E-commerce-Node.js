const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');

const StoreLocationModel = {
    
    getAllStoreLocations : async () => {
       const query = {
        text: 'SELECT * FROM store_location',
       };
       try {
         const results = await pool.query(query);
         if (results.rows.length === 0) {
            logger.error(`store_location return failed`);
            return 0
         } 
         logger.info(`store locations returned successfuly ${results.rows}`);
         return results
       } catch(error) {
        logger.error(`Error fetching store locations: ${error.message}`);
        throw error;
    }
 },

    getStoreLocationById : async (id) => {
       const query = {
         text: 'SELECT * FROM store_location WHERE id = $1',
         value : [id]
       };

       try { 
         const result = await pool.query(query);
         if (result.rows.length !== 1) {
             logger.error(`No store_location found by ID : ${id}`);
             return 0;
         } else if (result.rows.length === 1) {
            logger.info(`store_location returned by id ${result.rows[0]}`);
            return result.rows[0];
         }
       } catch (error) {
        logging.error(`Error fetching store_location : ${error.message}`);
        throw error;
       }
    },

    createStoreLocation : async (city_id,store_id,contact_phone,contact_email,floor=0,geom_location) => {
        const query = {
            text: `INSERT INTO store_location (id_city,id_store,contact_phone,contact_email,floor,geom_location)
            VALUES ($1,$2,$3,$4,$5,$6) RETURNING *`,
            values:[city_id,store_id,contact_phone,contact_email,floor,geom_location]
        };
        try {
            const results = await pool.query(query);
            if (!(results.rowCount > 0)) {
                logger.error(`Error in StoreLocation creation`);
                return 0;
            }
            logger.info(`StoreLocation created successfully: ${results.rows[0]}`)
            return results
        } catch (error) {
            logger.error(`Error in StoreLocation creation: ${error.message}`);
            throw error;
        }
    },

    updateStoreLocation : async (city_id,store_id,contact_phone,contact_email,floor=0,geom_location) => {
        const query = {
            text: `UPDATE store_location SET id_city = $1, id_store = $2, contact_phone = $3, contact_email = $4, floor = $5, geom_location = $6
                   WHERE id = $7`,
            values: [city_id,store_id,contact_phone,contact_email,floor,geom_location,id] 
        };
        try {
            const result = await pool.query(query);
            if (result.rows.length !== 1) {
                logger.error(`Error in updating store location`);
                return 0;
            } else if (result.rows.length === 1) {
                logger.info(`Store Location updated successfully: ${result.rows[0]}`);
                return result.rows
            }
        } catch (error) {
            logger.error(`Error in store location update: ${error.message}`);
            throw error;
        }
    },

    deleteStoreLocation : async (id) => {
        const query = {
            text: 'DELETE FROM store_location WHERE id = $1 RETURNING *',
            values: [id]
        };

        try {
             const result = await pool.query(query);
             if (!result.rowCount > 0) {
                logger.error(`No store location found with the given ID : ${id}`);
                return 0;
             } 
             logger.info(`Deleted Successful: `,result.rows[0]);
             return result

        } catch (error) {
            logger.error(`Error in deleting a store location: ${error.message}`);
            throw error 
        }
    }
}
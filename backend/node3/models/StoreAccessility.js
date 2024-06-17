const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');
const districtUtils = require('../utility/dbUtils.js');

const StoreAccessiblityModel = {
    
    getAllStoreAccessiblity: async () => {
       const query = {
        text: 'SELECT * FROM store_accessiblity',
       };
       try {
         const results = await pool.query(query);
         if (results.rows.length === 0) {
            logger.error(`store_accessiblity return failed`);
            return 0
         } 
         logger.info(`store_accessiblity returned successfuly ${results.rows}`);
         return results
       } catch(error) {
        logger.error(`Error fetching store_accessiblity: ${error.message}`);
        throw error;
    }
    },

    getStoreAccessiblityId : async (id) => {
       const query = {
         text: 'SELECT * FROM store_accessiblity WHERE id = $1',
         value : [id]
       };

       try { 
         const result = await pool.query(query);
         if (result.rows.length !== 1) {
             logger.error(`No StoreAccessiblity found by ID : ${id}`);
             return 0;
         } else if (result.rows.length === 1) {
            logger.info(`StoreAccessiblity returned by id ${result.rows[0]}`);
            return result;
         }
       } catch (error) {
        logging.error(`Error fetching StoreAccessiblity : ${error.message}`);
        throw error;
       }
    },

    getStoreAccessiblityByStoreLocation : async (id) => {
        const query = {
          text: 'SELECT * FROM store_accessiblity WHERE id_store_location = $1',
          value : [id]
        };
 
        try { 
          const result = await pool.query(query);
          if (result.rows.length !== 1) {
              logger.error(`No StoreAccessiblity found by store location ID : ${id}`);
              return 0;
          } else if (result.rows.length === 1) {
             logger.info(`StoreAccessiblity returned by store location ID ${result.rows[0]}`);
             return result;
          }
        } catch (error) {
         logging.error(`Error fetching StoreAccessiblity by Store location ID : ${error.message}`);
         throw error;
        }
     },

    createStoreAccessiblity: async (id_store_location,is_parking_accessible,is_restroom_accessible,is_wheelchair_accessible) => {
        const query = {
            text: `INSERT INTO store_accessiblity (id_store_location,is_parking_accessible,is_restroom_accessible,is_wheelchair_accessible)
            VALUES ($1,$2,$3,$4) RETURNING *`,
            values:[id_store_location,is_parking_accessible,is_restroom_accessible,is_wheelchair_accessible]
        };
        try {
            const results = await pool.query(query);
            if (!(results.rowCount > 0)) {
                logger.error(`Error in store_accessiblity creation`);
                return 0;
            }
            logger.info(`store_accessiblity created successfully: ${results.rows[0]}`)
            return results
        } catch (error) {
            logger.error(`Error in store_accessiblity creation: ${error.message}`);
            throw error;
        }
    },

    updateStoreAccessiblity : async (id,id_store_location,is_parking_accessible,is_restroom_accessible,is_wheelchair_accessible) => {
        const query = {
            text: `UPDATE store_location SET id_store_location = $1, is_parking_accessible = $2, is_restroom_accessible = $3, is_wheelchair_accessible = $4
                   WHERE id = $5`,
            values: [id_store_location,is_parking_accessible,is_restroom_accessible,is_wheelchair_accessible] 
        };
        try {
            const result = await pool.query(query);
            if (result.rows.length !== 1) {
                logger.error(`Error in creating store_location`);
                return 0;
            } else if (result.rows.length === 1) {
                logger.info(`store_location updated successfully: ${result.rows[0]}`);
                return result.rows
            }
        } catch (error) {
            logger.error(`Error in store_location update: ${error.message}`);
            throw error;
        }
    },

    deleteStoreLocation: async (id) => {
        const query = {
            text: 'DELETE FROM store_location WHERE id = $1 RETURNING *',
            values: [id]
        };

        try {
             const result = await pool.query(query);
             if (!result.rowCount > 0) {
                logger.error(`No store_location found with the given ID : ${id}`);
                return 0;
             } 
             logger.info(`Deleted Successful: `,result.rows[0]);
             return result.rows

        } catch (error) {
            logger.error(`Error in deleting a store_location: ${error.message}`);
            throw error 
        }
    }
}
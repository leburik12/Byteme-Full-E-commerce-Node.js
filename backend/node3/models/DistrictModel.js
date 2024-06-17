const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');
const districtUtils = require('../utility/dbUtils.js');

const DistrictModel = {
    
    getAllDistricts: async () => {
       const query = {
        text: 'SELECT * FROM districts',
       };
       try {
         const districts = await pool.query(query);
         if (districts.rows.length === 0) {
            logger.error(`Districts return failed`);
            return 0
         } 
         logger.info(`Districts returned successfuly ${districts.rows}`);
         return districts.rows
       } catch(error) {
        logger.error(`Error fetching roles: ${error.message}`);
        throw error;
    }
    },

    getDistrictById : async (id) => {
       const query = {
         text: 'SELECT * FROM districts WHERE id = $1',
         value : [id]
       };

       try { 
         const result = await pool.query(query);
         if (result.rows.length !== 1) {
             logger.error(`No District found by ID : ${id}`);
             return 0;
         } else if (result.rows.length === 1) {
            logger.info(`District returned by id ${result.rows[0]}`);
            return result.rows[0];
         }
       } catch (error) {
        logging.error(`Error fetching districts : ${error.message}`);
        throw error;
       }
    },

    createDistrict: async (district_name,city_id,is_shipping_available=true) => {
        const query = {
            text: `INSERT INTO districts (district_name,city_id,is_shipping_available)
            VALUES ($1,$2,$3) RETURNING *`,
            values:[district_name,city_id,is_shipping_available]
        };
        try {
            const districts = await pool.query(query);
            if (!(districts.rowCount > 0)) {
                logger.error(`Error in district creation`);
                return 0;
            }
            logger.info(`District created successfully: ${districts.rows[0]}`)
            return districts.rows
        } catch (error) {
            logger.error(`Error in district creation: ${error.message}`);
            throw error;
        }
    },

    updateDistrict : async (id,district_name,city_id,is_shipping_available=true) => {
        const query = {
            text: `UPDATE districts SET district_name = $1, id_city = $2, is_shipping_available = $3
                   WHERE id = $4`,
            values: [district_name,city_id,is_shipping_available,id] 
        };
        try {
            const result = await pool.query(query);
            if (result.rows.length !== 1) {
                logger.error(`Error in creating district`);
                return 0;
            } else if (result.rows.length === 1) {
                logger.info(`district updated successfully: ${result.rows[0]}`);
                return result.rows
            }
        } catch (error) {
            logger.error(`Error in district update: ${error.message}`);
            throw error;
        }
    },

    deleteDistrit: async (id) => {
        const query = {
            text: 'DELETE FROM districts WHERE id = $1 RETURNING *',
            values: [id]
        };

        try {
             const result = await pool.query(query);
             if (!result.rowCount > 0) {
                logger.error(`No district found with the given ID : ${id}`);
                return 0;
             } 
             logger.info(`Deleted Successful: `,result.rows[0]);
             return result.rows

        } catch (error) {
            logger.error(`Error in deleting a district: ${error.message}`);
            throw error 
        }
    }
}
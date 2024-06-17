const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');
const districtUtils = require('../utility/dbUtils.js');

const StoreDetailModel = {


    getStoreDetailById : async (id) => {
       const query = {
         text: 'SELECT * FROM store_detail WHERE id = $1',
         value : [id]
       };

       try { 
         const result = await pool.query(query);
         if (result.rows.length !== 1) {
             logger.error(`No store_detail found by ID : ${id}`);
             return 0;
         } else if (result.rows.length === 1) {
            logger.info(`store_detail returned by id ${result.rows[0]}`);
            return result;
         }
       } catch (error) {
        logging.error(`Error fetching store detail : ${error.message}`);
        throw error;
       }
    },

    createStoreDetail: async (id_store_location,id_store,addr,is_main_branch,
        open_time,close_time,is_delivery_available,website_url,is_active) => {
        const query = {
            text: `INSERT INTO store_detail (id_store_location,id_store,addr,is_main_branch,
                open_time,close_time,is_delivery_available,website_url,is_active)
            VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9) RETURNING *`,
            values:[id_store_location,id_store,addr,is_main_branch,open_time,close_time,
                is_delivery_available,website_url,is_active]
        };
        try {
            const results = await pool.query(query);
            if (!(results.rowCount > 0)) {
                logger.error(`Error in store detail creation`);
                return 0;
            }
            logger.info(`Store detail created successfully: ${results.rows[0]}`)
            return results
        } catch (error) {
            logger.error(`Error in store detail creation: ${error.message}`);
            throw error;
        }
    },

    updateStoreDetail : async (id,id_store_location,id_store,addr,is_main_branch,
        open_time,close_time,is_delivery_available,website_url,is_active=true) => {
        const query = {
            text: `UPDATE store_detail SET id_store_location = $1, id_store = $2, addr = $3, is_main_branch = $4,
                   open_time = $5, close_time = $6, is_delivery_available = $7, website = $8, is_active = $9 WHERE id = $10`,
            values: [id_store_location,id_store,addr,is_main_branch,
                open_time,close_time,is_delivery_available,website_url,is_active,id] 
        };
        try {
            const result = await pool.query(query);
            if (result.rows.length !== 1) {
                logger.error(`Error in creating Store detail`);
                return 0;
            } else if (result.rows.length === 1) {
                logger.info(`Store detail updated successfully: ${result.rows[0]}`);
                return result
            }
        } catch (error) {
            logger.error(`Error in store detail update: ${error.message}`);
            throw error;
        }
    },

    deleteStoreDetail: async (id) => {
        const query = {
            text: 'DELETE FROM store_detail WHERE id = $1 RETURNING *',
            values: [id]
        };

        try {
             const result = await pool.query(query);
             if (!result.rowCount > 0) {
                logger.error(`No store_detail found with the given ID : ${id}`);
                return 0;
             } 
             logger.info(`Deleted Successful: `,result.rows[0]);
             return result

        } catch (error) {
            logger.error(`Error in deleting a store_detail: ${error.message}`);
            throw error 
        }
    },
}
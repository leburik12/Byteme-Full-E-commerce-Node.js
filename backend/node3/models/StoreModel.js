const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');
const districtUtils = require('../utility/dbUtils.js');

const StoreModel = {
    
    getAllStores : async (limit, offset) => {
       const query = {
        text: 'SELECT * FROM store ORDER BY id ASC LIMIT $2 OFFSET $3',
       };
       try {
         const results = await pool.query(query);
         if (results.rows.length === 0) {
            logger.error(`stores return failed`);
            return { success: false }
         } 
         logger.info(`results returned successfuly ${results.rows}`);
        return {  
                success: true,
                result: results.rows
            }
       } catch(error) {
        logger.error(`Error fetching roles: ${error.message}`);
        throw error;
      }
    },

    getAllStoreLocationsByStoreId : async (id) => {
       const query = {
        text: 'SELECT * FROM store_location id_store =$1',
        values: [id]
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

    getStoreById : async (id) => {
       const query = {
         text: 'SELECT * FROM store WHERE id = $1',
         value : [id]
       };

       try { 
         const result = await pool.query(query);
         if (result.rows.length !== 1) {
             logger.error(`No Store found by ID : ${id}`);
             return {
                    success: false
                }
         } else if (result.rows.length === 1) {
            logger.info(`Store returned by id ${result.rows[0]}`);
            return {
                    success: true,
                    result: result.rows[0]
                }
         }
       } catch (error) {
        logging.error(`Error fetching Store : ${error.message}`);
        throw error;
       }
    },

    getStoreJoinInventory : async (id,limit,offset) => {
      const query = {
        text: "SELECT * FROM store JOIN inventory ON store.id = inventory.id_store WHERE store.id = $1 ORDER BY id ASC LIMIT $2 OFFSET $3",
        values: [id,limit,offset]
      };
      try {
            const result = await pool.query(query);
           if (result.rows.length === 0) {
            logger.error(`No product found in the store.`);
             return {
                success: false
               }
        } 
           logger.info(`Products found`);
           return {
                success: true,
                message: result.rows
               }    
      } catch (error) {
        logger.error(`Error getting product in the store : ${error.message}`);
        throw error;
      }
    },
    
    getNearByStores : async (longtiude, latitude, distance) => {
        const query = {
            text: `
                SELECT store.* , store_location.* from store INNER JOIN store_location ON store.id = store_location.id_store
                WHERE ST_DWithin(
                store_location.geom_location,
                ST_SetSRID(ST_MakePoint($1,$2),4326),
                $3
                );`,
            values: [longtiude,latitude,distance]
        };

        try {
            const res = await pool.query(query);
            if (result.rows.length === 0) {
            logger.error(`No stores found within your distance.`);
            return {
                success: false
             }
           }

           logger.info(`stores found with in your distance`);
           return {
                success: true,
                message: result.rows
               }
        } catch (error) {
            logger.error(`Error getting nearby stores : ${error.message}`);
            throw error;
        }
    },
     
    // Get Nearby Stores By Store Choices - 'liquior','coffee shop','cafe','supermarket','mini-market','restaurants','bar'
    getNearByStoresByStoreChoice : async (longtiude, latitude, distance, store_choice) => {
        const query = {
            text: `
                SELECT store.* , store_location.* from store INNER JOIN store_location ON store.id = store_location.id_store
                WHERE store.store_choice = $1 AND ST_DWithin(
                store_location.geom_location,
                ST_SetSRID(ST_MakePoint($2,$3),4326),
                $4
                );`,
            values: [store_choice,longtiude,latitude,distance]
        };

        try {
            const res = await pool.query(query);
            if (result.rows.length === 0) {
            logger.error(`No stores found within your distance.`);
            return {
                success: false
             }
           }

           logger.info(`stores found with in your distance`);
           return {
                success: true,
                message: result.rows
               }
        } catch (error) {
            logger.error(`Error getting nearby stores : ${error.message}`);
            throw error;
        }
    },

    createStore: async (name,description,brand_name,branchs,store_type,id_user,file_path) => {
        const query = {
            text: `INSERT INTO store (name,description,brands_name,branchs,store_type,id_user,file_path)
            VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING *`,
            values:[name,description,brand_name,branchs,store_type,id_user,file_path]
        };
        try {
            const results = await pool.query(query);
            if (!(results.rowCount > 0)) {
                logger.error(`Error in store creation`);
                return {
                    success: false,
                }
            }
            logger.info(`Store created successfully : ${results.rows[0]}`)
            return {
                    success: true,
                    result: results.rows[0].id
                }
        } catch (error) {
            logger.error(`Error in Store creation: ${error.message}`);
            throw error;
        }
    },

    createStoreDocumentation : async (id_store,id_user,description,file_path) => {
        const query = {
            text: `INSERT INTO store_document_ownership (id_store,id_user,description,file_path)
            VALUES ($1,$2,$3,$4) RETURNING *`,
            values:[id_store,id_user,description,file_path]
        };
        try {
            const results = await pool.query(query);
            if (results.rowCount === 0) {
                logger.error(`No changes in store_document_ownership creation`);
                return {
                    success: false,
                }
            }
            logger.info(`store_document_ownership created successfully: ${results.rows[0]}`)
            return {
                    success: true,
                    result: results.rows[0]
                }
        } catch (error) {
            logger.error(`Error in store_document_ownership creation: ${error.message}`);
            throw error;
        }
    },

    createStoreLocation : async (city_id,store_id,contact_phone,contact_email,floor=0,longtiude,latitude) => {
        const query = {
            text: `INSERT INTO store_location (id_city,id_store,contact_phone,contact_email,floor,geom_location)
            VALUES ($1,$2,$3,$4,$5,ST_SetSRID(ST_MakePoint($6,$7), 4326)) RETURNING *`,
            values:[city_id,store_id,contact_phone,contact_email,floor,longtiude,latitude]
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

    updateStore : async (id,name,description,brand_name,
        website_url,approved=false,branchs,postal_code,store_choice) => {
        const query = {
            text: `UPDATE store SET name = $1, description = $2, brand_name = $3, website_url = $4, approved = $5
                   branchs = $6, postal_code = $7, store_choice = $8, WHERE id = $9`,
            values: [name,description,brand_name,website_url,approved,branchs,postal_code,store_choice,id] 
        };
        try {
            const result = await pool.query(query);
            if (result.rows.length !== 1) {
                logger.error(`Error in creating store`);
                return {
                    success: false,
                }
            } else if (result.rows.length === 1) {
                logger.info(`store updated successfully: ${result.rows[0]}`);
                return {
                    success: true,
                    result: result.rows[0]
                }
            }
        } catch (error) {
            logger.error(`Error in store update: ${error.message}`);
            throw error;
        }
    },

    updateStoreLocation : async (city_id,store_id,contact_phone,contact_email,floor=0,longtiude,latitude,id) => {
        const query = {
            text: `UPDATE store_location SET id_city = $1, id_store = $2, contact_phone = $3, contact_email = $4,
            floor = $5, geom_location = ST_SetSRID(ST_MakePoint($6,$7),4326) WHERE id = $8`,
            values: [city_id,store_id,contact_phone,contact_email,floor,longtiude,latitude,id] 
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

    deleteStore: async (id) => {
        const query = {
            text: 'DELETE FROM store WHERE id = $1 RETURNING *',
            values: [id]
        };

        try {
             const result = await pool.query(query);
             if (!result.rowCount > 0) {
                logger.error(`No store found with the given ID : ${id}`);
                return {
                    success: false
                }
             } 
             logger.info(`Deleted Successful: `,result.rows[0]);
             return {
                    success: true,
                    result: result.rows[0]
                }

        } catch (error) {
            logger.error(`Error in deleting a store: ${error.message}`);
            throw error 
        }
    },

     deleteStoreLocation : async (id_store) => {
        const query = {
            text: 'DELETE FROM store_location WHERE id_store = $2 RETURNING *',
            values: [id_store]
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

module.exports = { StoreModel };
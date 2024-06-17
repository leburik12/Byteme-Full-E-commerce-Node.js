const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');


const UserPermissionEntityModel = {
    
    getAllUserPermissionEntity: async () => {
       const query = {
        text: 'SELECT * FROM user_permission_entity',
       };
       try {
         const results = await pool.query(query);
         if (results.rows.length === 0) {
            logger.error(`user_permission_entity return failed`);
            return 0
         } 
         logger.info(`user_permission_entity returned successfuly ${results.rows}`);
         return results.rows
       } catch(error) {
        logger.error(`Error fetching roles: ${error.message}`);
        throw error;
    }
    },

    getUserPermissionEntityById : async (id) => {
       const query = {
         text: 'SELECT * FROM user_permission_entity WHERE id = $1',
         value : [id]
       };

       try { 
         const result = await pool.query(query);
         if (result.rows.length !== 1) {
             logger.error(`No user_permission_entity found by ID : ${id}`);
             return 0;
         } else if (result.rows.length === 1) {
            logger.info(`user_permission_entity returned by id ${result.rows[0]}`);
            return result.rows[0];
         }
       } catch (error) {
        logging.error(`Error fetching user_permission_entity : ${error.message}`);
        throw error;
       }
    },

    createUserPermissionEntity: async (user_id,table_list_id,operation,permission_name) => {
        const query = {
            text: `INSERT INTO user_permission_entity (user_id,table_list_id,operation,permission_name)
            VALUES ($1,$2,$3,$4) RETURNING *`,
            values:[user_id,table_list_id,operation,permission_name]
        };
        try {
            const results = await pool.query(query);
            if (!(results.rowCount > 0)) {
                logger.error(`Error in user_permission_entity creation`);
                return 0;
            }
            logger.info(`user_permission_entity created successfully: ${results.rows[0]}`)
            return results
        } catch (error) {
            logger.error(`Error in user_permission_entity creation: ${error.message}`);
            throw error;
        }
    },

    updateUserPermissionEntity : async (user_id,table_list_id,operation,permission_name) => {
        const query = {
            text: `UPDATE user_permission_entity SET user_id = $1, table_list_id = $2, operation = $3, permission_name = $4
                   WHERE id = $4`,
            values: [user_id,table_list_id,operation,permission_name] 
        };
        try {
            const result = await pool.query(query);
            if (result.rows.length !== 1) {
                logger.error(`Error in creating user_permission_entity`);
                return 0;
            } else if (result.rows.length === 1) {
                logger.info(`user_permission_entity updated successfully: ${result.rows[0]}`);
                return result.rows
            }
        } catch (error) {
            logger.error(`Error in user_permission_entity update: ${error.message}`);
            throw error;
        }
    },

    deleteUserPermissionEntity: async (id) => {
        const query = {
            text: 'DELETE FROM user_permission_entity WHERE id = $1 RETURNING *',
            values: [id]
        };

        try {
             const result = await pool.query(query);
             if (!result.rowCount > 0) {
                logger.error(`No user_permission_entity found with the given ID : ${id}`);
                return 0;
             } 
             logger.info(`user_permission_entity Successful: `,result.rows[0]);
             return result.rows

        } catch (error) {
            logger.error(`Error in user_permission_entity a district: ${error.message}`);
            throw error 
        }
    }
};
module.exports = UserPermissionEntityModel;
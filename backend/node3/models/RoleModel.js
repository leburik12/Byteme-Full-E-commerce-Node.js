const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');

const RoleModel = {

    getAllRoles: async (limit,offset) => {
        const query = {
            text: 'SELECT * FROM roles ORDER BY id ASC LIMIT $1 OFFSET $2',
            values: [limit, offset]
        };
    try {  
        const result = await pool.query(query);
        if (result.rows.length === 0) {
          logger.error('Roles return failed');
          return 0;
        } 
        logger.info(`ROle returned successfuly ${result.rows}`);
        return result.rows;
      } catch (error) {
        logger.error(`Error fetching roles: ${error.message}`);
        throw error;
      }  
    },

    getRoleById: async (id) => {
        const query = {
            text: 'SELECT * FROM roles where id = $1',
            value: [id],
         };
        try {
           const result = await pool.query(query);
           if (!result.rows || result.rows.length === 0) {
            throw new Error(`Error fetching roles by ID : ${error.message}`);
           }
           return result;
        } catch (error) {
             logger.error(`Error getting role by id : ${error.message}`);
             throw error;
        }
    },

    createRole: async (role_name,description, isactive=true) => {
        const query = {
            text: 'INSERT INTO roles(role_name,description,isactive) VALUES ($1,$2,$3) RETURNING *',
            values: [role_name,description,isactive],
         };
    	try {
           const result = await pool.query(query);
           if (result.rowCount === 0) {
            logger.error('No rows are inserted');
            return 0;
           } else {
            logger.info(`Roles created successfully: ${result.rows[0].id}`);
            return result.rows[0]
           }
	  } catch (error) { 
        logger.error(`Error in creating role: ${error.message}`);
        throw error;
      }
    },

    updateRole: async (id,role_name, description, isactive=true) => {
        const query = {
            text:   'UPDATE roles set role_name = $1,description = $2,isactive = $3 WHERE id = $4 RETURNING *',
            values: [role_name,description,isactive],
        };  
        try {
        const result = await pool.query(query);
        if (result.rows.length > 0) {
            const updatedRole = result.rows[0];
            logger.info(`Roles updated successfully: ${updatedRole}`);
            return updatedRole;
        } else {
            logger.error(`Error in creating roles`);
            return 0;
        }
       } catch (error) {   
           logger.error(`Error update role with given ID: ${id}`);
           throw error;
       }
    },

    deleteRole: async (id) => {
      const query = {
        text:   'DELETE FROM roles WHERE id = $1 RETURNING *',
        values: [id],
      };

      try {
          const result = await pool.query(query);
          if (result.rowCount === 0) {
             logger.error(`role with id - ${id} not found`);
          } else{
          logger.info(`Successfully deleted role with id : ${id}`);
          return result;
        }
      } catch (error) {
        logger.error(`Error in deleting role: ${error.message}`);
        throw error;
      }
    },       
}
module.exports = RoleModel;

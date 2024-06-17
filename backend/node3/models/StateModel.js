const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');

const StateModel = {

    getAllStates: async () => {
        const query = {
            text: 'SELECT * FROM states',
        };
    try {  
        const result = await pool.query(query);
        if (result.rows.length === 0) {
            logger.error('State return failed');
            return 0;
        } 
        logger.info(`State returned successfuly ${result.rows}`);
        return result.rows;
      } catch (error) {
        logger.error(`Error fetching states: ${error.message}`);
        throw error;
      }  
    },

    getStateById: async (id) => {
        const query = {
            text: 'SELECT * FROM states where id = $1',
            value: [id],
         };
        try {
           const result = await pool.query(query);
           if (!result.rows || result.rows.length === 1) {
            logger.error(`Error getting states by id : ${error.message}`);
            return 0;
           }
           return result;
        } catch (error) {
             logger.error(`Error getting role by id : ${error.message}`);
             throw error;
        }
    },

    createState: async (state_name,country_id) => {
        const query = {
            text: 'INSERT INTO states (state_name,country_id) VALUES ($1,$2) RETURNING *',
            values: [state_name,country_id],
         };
    	try {
           const result = await pool.query(query);
           if (result.rowCount === 0) {
            logger.error('No rows are inserted');
            return 0;
           } else {
            logger.info(`Roles created successfully: ${result.rows}`);
            return result;
           }
	  } catch (error) { 
        logger.error(`Error in creating role: ${error.message}`);
        throw error;
      }
    },

    updateState: async (id,state_name, country_id) => {
        const query = {
            text:   'UPDATE states set state_name = $1,country_id = $2 WHERE id = $3 RETURNING *',
            values: [state_name,country_id,id],
        };  
        try {
        const result = await pool.query(query);
        if (result.rows.length !== 1) {
            logger.error(`Error in creating states`);
            return 0;
        } else {
            const updatedState = result.rows[0];
            logger.info(`State updated successfully: ${updatedState}`);
            return updatedState;
        }
       } catch (error) {   
           logger.error(`Internal sever error : ${id}`);
           throw error;
       }
    },

    deleteState: async (id) => {
      const query = {
        text:   'DELETE FROM states WHERE id = $1 RETURNING *',
        values: [id],
      };

      try {
          const result = await pool.query(query);
          if (result.rowCount === 0) {
             logger.error(`State with id - ${id} not found`);
             return 0;
          } else{
          logger.info(`Successfully deleted state with id : ${id}`);
          return result;
        }
      } catch (error) {
        logger.error(`Error in deleting state: ${error.message}`);
        throw error;
      }
    },       
}
module.exports = StateModel;

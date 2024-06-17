const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');

const checkForeignKeysExist = async (id, tableName) => {
        const query = `SELECT COUNT(*) FROM ${tableName} WHERE id=$1`;
        try {
          const result = await pool.query(query,[id]);
          return result.rows.length === 1;
      } catch (error) {
        logger.error(`Error in checkForeignKeysExist : ${error.message}`);
        throw error;
      }
    };
const checkColumnExists = async (columname, tableName, value) => {
      const query = {
        text: `SELECT COUNT(*) FROM ${tableName} WHERE ${columname} = $1`,
        values: [value]
      };

      try {
         const result = await pool.query(query);
         return result
      } catch (error) {
        logger.error(`Error in checkColumnExists :  ${error.message}`);
        throw error;
      }
}

module.exports = { checkForeignKeysExist, checkColumnExists };
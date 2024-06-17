const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');
require('dotenv').config();

const UserModel = {

    saltRounds : 10,

    checkForeignKeysExist: async (id,tableName) =>  {
        const query = `SELECT COUNT(*) FROM ${tableName} WHERE id = $1`;
        const result = await pool.query(query, [id]);
        return result.rows[0].count > 0;
    },

    checkUniqueness: async (tableName,columnType, value) => {
        const query = `SELECT COUNT(*) FROM ${tableName} WHERE ${columnType} = $1`;
        const result = await pool.query(query, [value]);
        return result.rows[0].count === 1;
    },

    getAllUsers : async (limit,offset) => {
        const query = {
            text: 'SELECT * FROM "user" ORDER BY id ASC LIMIT $1 OFFSET $2',
            values: [limit, offset]
        };
        try {
          const users = await pool.query(query);
          if (users.rows.length === 0) {
            logger.error('Users return failed');
            return {
                success: false,
            }
          }
          logger.info(`Users returned successfuly ${users.rows}`);
           return {
                success: true,
                message: districts.rows 
            } 
        } catch (error) {
            logger.error(`Error fetching users : ${error.message}`);
            throw error;
        }
    },

    getUserById : async (id) => {
        const query = {
            text: 'SELECT * FROM "user" WHERE id = $1',
            value : [id],
        };
        try {
            const result = await pool.query(query);
            if (result.rows.length !== 1) {
                logger.error(`No User found by ID : ${id}`);
                return {
                success: false
               } 
            } else if (result.rows.length === 1) {
                logger.info(`User returned by ID : ${id}`);
                return {
                   success: true,
                   message: result.rows[0]
               }
            }
        } catch(error) {
            logging.error(`Error fetching users : ${error.message}`)
            throw error;
        }
    },

    createUser: async (id_role,first_name,last_name,phone,gender,email,password_hash) => {
        const query = {
            text: `INSERT INTO "user" (id_role,first_name,last_name,phone,gender,email,password_hash)
                 VALUES($1,$2,$3,$4,$5,$6,$7) RETURNING *`,
            values : [id_role,first_name,last_name,phone,gender,email,password_hash]
        };
        
        try {
            /*
            let passwordHashed;
            try {
                passwordHashed = await bcrypt.hash(password_hash,this.saltRounds);
            } catch (error) {
                logging.error(`Error generating hash : ${error.message}`)
                throw error;
            }
            */
        const user =  await pool.query(query);
        if (user.rowCount > 0) {
            logger.info(`User created successfully: ${user.rows[0]}`);
            return {
                success: true,
                createdUser:  user.rows[0]
             }
         } else {
            logger.error('No rows are inserted');
            return {
                success: false,
            }
          } 
        } catch (error) {
            logger.error(`Error in user creation userModel : ${error.message}`);
            throw error;
        }
    },

    updateUser: async (id,id_role,first_name,last_name,gender,is_active) => {
        const query = {
            text: 'UPDATE "user" set id_role  = $1 , first_name = $2, last_name = $3 , gender = $4 , is_active = $5 WHERE id = $6 RETURNING *',
            values: [id_role,first_name,last_name,gender,is_active,id]
        };

        try {
            const result = await pool.query(query);
            if (result.rows.length > 0) {
                logger.info(`User updated successfully: ${result.rows[0]}`)
                return {
                   success: true,
                   updatedUser:  result.rows[0]
                }
            } else {
                logger.error(`Error in creating user`);
                return {
                    success: false,
                }
            }
        } catch (error) {
            logger.error(`Error in update user: ${error.message}`);
            throw error;
        }
    },

    deleteUser: async (id) => {
        const query = {
            text: 'DELETE FROM "user" WHERE id = $1 RETURNING *',
            values: [id]
        };

        try {
            const result = await pool.query(query);
            if (result.rowCount > 0) {
                logger.info(`Delete Successful: `,result.rows[0]);
                return {
                    success: true,
                    deletedRow: result.rows[0]
                }
            } else {
                logger.error(`No role found with the given ID : ${id}`);
                return {
                    success: false,
                }
            }
        } catch (error) {
            logger.error(`Error in deleting a user: ${error.message}`);
            throw error;
        }
    },

    getUserPhoneNum : async (phone) => {
          const query = {
            text: `SELECT CONCAT(first_name,' ',last_name) as name,password_hash,id,user_uuid,id_role FROM "user" WHERE phone = $1 AND is_active = $2`,
            values: [phone,true]
          };

          try {
              const result = await pool.query(query);

            if (result.rows.length !== 1) {
                logger.error(`Invalid credential. : ${phone}`);
                return { success: false }
            } else if (result.rows.length === 1) {
                logger.info(`getUserPhoneNum::User returned by phone number : ${phone}`);
                return { success: true, result: result.rows[0] };
            }

          } catch (error) {
            logger.error(`Error in Login. ${error.message}`);
            throw error;
          }
    },

    assignRoleToUser : async () => {
        
    }
}

module.exports =  UserModel ;
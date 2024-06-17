const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');
const { getUserAddress } = require('../cache/cacheData.js');
require('dotenv').config();

const OrderModel = {

    getAllOrder : async (limit,offset) => {
        const query = {
            text: 'SELECT * FROM "order" ORDER BY id ASC LIMIT $1 OFFSET $2',
        };
        try {
          const users = await pool.query(query);
          if (users.rows.length === 0) {
            logger.error('Order return failed');
            return {
                success: false,
            }
          }
          logger.info(`Orders returned successfuly ${users.rows}`);
           return {
                success: true,
                message: districts.rows 
            } 
        } catch (error) {
            logger.error(`Error fetching Orders : ${error.message}`);
            throw error;
        }
    },

    getOrderById : async (id) => {
        const query = {
            text: 'SELECT * FROM "order" WHERE id = $1',
            value : [id],
        };
        try {
            const result = await pool.query(query);
            if (result.rows.length !== 1) {
                logger.error(`No Order found by ID : ${id}`);
                return {
                success: false
               } 
            } else if (result.rows.length === 1) {
                logger.info(`Order returned by ID : ${id}`);
                return {
                   success: true,
                   message: result.rows[0]
               }
            }
        } catch(error) {
            logging.error(`Error fetching Order : ${error.message}`)
            throw error;
        }
    },

    getOrderByUserId: async (id) => {
        const query = {
            text: 'SELECT * FROM "order" WHERE id_customer = $1',
            value : [id],
        };

        try {
            const result = await pool.query(query);
            if (result.rows.length !== 1) {
                logger.error(`No Order found by User ID : ${id}`);
                return {
                success: false
               } 
            } else if (result.rows.length === 1) {
                logger.info(`Order returned by ID : ${id}`);
                return {
                   success: true,
                   message: result.rows[0]
               }
            }
        } catch(error) {
            logging.error(`Error fetching Order by User id : ${error.message}`)
            throw error;
        }
    },

    createOrder : async (id_customer,internal_notes,order_priority,coordinates) => 
        {
        const query = {
            text: `INSERT INTO "order" (id_customer,${internal_notes ? ', internal_notes' : ''},order_priority,coordinates)
                 VALUES($1,$2,$3,$4 RETURNING *`,
            values : [id_customer,internal_notes,order_priority,coordinates]
        };
        
        try {
            const order =  await pool.query(query);
            if (order.rowCount > 0) {
                logger.info(`Order created successfully: ${order.rows[0]}`);
                    
            return {
                success: true,
                createdUser:  order.rows[0]
             }
           } else {
                logger.error('No Order are inserted');
                return {
                    success: false,
                }
            } 
        } catch (error) {
            await client.query('ROLLBACK');
            logger.error(`Error in order creation orderModel : ${error.message}`);
            throw error;
        }
    },

    createOrderItem : async (order_items) => {
        let failOrderCount = 0;
        try {
            for (const item in order_items) {
                const { id_inventory, quantity, unit_price} = item;

                if (!id_inventory || !quantity || !unit_price) {
                    throw new Error('Invalid order item: missing required fields');
                }

                const query = `
                    INSERT INTO order_item (id_order, id_inventory, quantity, unit_price)
                    VALUES ($1,$2,$3,$4);
                `;
                const orderItems = await pool.query(query, id_inventory,quantity,unit_price);
                logger.info(`Order Item created successfully: ${orderItems.rows[0]}`);
            }
       } catch (error) {
            logger.error(`Error in orderItem creation : ${error.message}`);
            throw error;
      } 
    },

    /*
    createOrder : async (id_customer,id_status,id_delivery_method,id_fullfillment,
        shipping_method,promotion_code,internal_notes,order_priority,discount_amount,shipping_cost) => {
        const query = {
            text: `INSERT INTO "user" (id_customer,id_status,id_delivery_method,id_fullfillment,shipping_method,
                promotion_code,internal_notes,order_priority,discount_amount,shipping_cost)
                 VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) RETURNING *`,
            values : [id_customer,id_status,id_delivery_method,id_fullfillment,shipping_method,promotion_code,internal_notes,order_priority,discount_amount,shipping_cost]
        };
        
        try {
        const user =  await pool.query(query);
        if (user.rowCount > 0) {
            logger.info(`Order created successfully: ${user.rows[0]}`);
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
    */

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

module.exports =  OrderModel ;
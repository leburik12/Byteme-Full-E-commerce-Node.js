const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');
require('dotenv').config();

const GiftModel = {

    getAllGift : async (limit,offset) => {
        const query = {
            text: 'SELECT * FROM gift ORDER BY id ASC LIMIT $1 OFFSET $2',
            values: [limit, offset]
        };
        try {
          const gifts = await pool.query(query);
          if (gifts.rows.length === 0) {
            logger.error('gifts return failed');
            return {
                success: false,
            }
          }
          logger.info(`Gifts returned successfuly ${users.rows}`);
           return {
                success: true,
                message: gifts.rows 
            } 
        } catch (error) {
            logger.error(`Error fetching Gifts : ${error.message}`);
            throw error;
        }
    },

    getGiftById : async (id) => {
        const query = {
            text: 'SELECT * FROM gift WHERE id = $1',
            value : [id],
        };
        try {
            const result = await pool.query(query);
            if (result.rows.length !== 1) {
                logger.error(`No Gift found by ID : ${id}`);
                return {
                success: false
               } 
            } else if (result.rows.length === 1) {
                logger.info(`Gift returned by ID : ${id}`);
                return {
                   success: true,
                   message: result.rows[0]
               }
            }
        } catch(error) {
            logging.error(`Error fetching Gifts : ${error.message}`)
            throw error;
        }
    },

    getGiftJoinOrder : async (id) => {
        const query = {
            text: `
            
            SELECT 
                g.id AS gift_id,
                g.id_order,
                g.id_recipient,
                g.recipient_name,
                g.recipient_address,
                g.gift_message,
                g.instructions,
                g.date_added,
                g.is_delivered,
                o.id AS order_id,
                o.id_customer,
                o.id_status,
                o.id_delivery_method,
                o.id_fullfillment,
                o.shipping_method,
                o.promotion_code,
                o.internal_notes,
                o.order_priority,
                o.discount_amount,
                o.shipping_cost,
                o.paid,
                o.order_date
            FROM 
                gift g
            INNER JOIN 
                "order" o ON g.id_order = o.id 
            WHERE g.id_order = $1;`,
            value : [id],
        };
        try {
            const result = await pool.query(query);
            if (result.rows.length !== 1) {
                logger.error(`No Gift found by ID : ${id}`);
                return {
                success: false
               } 
            } else if (result.rows.length === 1) {
                logger.info(`Gift returned by ID : ${id}`);
                return {
                   success: true,
                   message: result.rows[0]
               }
            }
        } catch(error) {
            logging.error(`Error fetching Gifts : ${error.message}`)
            throw error;
        }
    },

    getGiftJoinUser : async (id) => {
        const query = {
            text: `
                  SELECT 
                        g.id AS gift_id,
                        g.id_order,
                        g.id_recipient,
                        g.recipient_name,
                        g.recipient_address,
                        g.gift_message,
                        g.instructions,
                        g.date_added,
                        g.is_delivered,
                        u.id AS user_id,
                        u.id_district,
                        u.user_uuid,
                        u.first_name,
                        u.last_name,
                        u.phone,
                        u.gender,
                        u.id_type,
                        u.email,
                        u.is_active,
                        u.is_id_verified
                    FROM 
                        gift g
                    INNER JOIN 
                        "user" u ON g.id_recipient = u.id
                    WHERE
                        g.id_recipient = $1 AND u.id = $2;
            `,
            values: [id,id]
        };

         try {
            const result = await pool.query(query);
            if (result.rows.length !== 1) {
                logger.error(`No Gift found by user ID : ${id}`);
                return {
                success: false
               } 
            } else if (result.rows.length === 1) {
                logger.info(`Gift returned by user ID : ${id}`);
                return {
                   success: true,
                   message: result.rows[0]
               }
            }
        } catch(error) {
            logging.error(`Error fetching Gifts by user id : ${error.message}`)
            throw error;
        }
    },

    createGift : async (id_order,id_recipient,recipient_name,recipient_address,gift_message,instructions) => {
        const query = {
            text: `INSERT INTO gift (id_order,id_recipient,recipient_name,recipient_address,gift_message ${instructions ? ', instructions' : ''})
                 VALUES($1,$2,$3,$4,$5 ${instructions ? ', $6' : ''}) RETURNING *`,
            values : [id_order,id_recipient,recipient_name,recipient_address,gift_message,instructions]
        };
        if(typeof instructions) {
           
        }
        try {
            const gift =  await pool.query(query);
            if (gift.rowCount > 0) {
                logger.info(`Gift created successfully: ${user.rows[0]}`);
                return {
                    success: true,
                    createdUser:  gift.rows[0]
                }
            } else {
                logger.error('No rows are inserted');
                return {
                    success: false,
                }
            } 
        } catch (error) {
            logger.error(`Error in Gift creation GiftModel : ${error.message}`);
            throw error;
        }
    },

    updateGift : async (id,id_order,id_recipient,recipient_name,recipient_address,gift_message,instructions) => {
        const query = {
            text: 'UPDATE gift set id_recipient = $1, recipient_name = $2 , recipient_address = $3 , gift_message = $4 , instructions = $5 WHERE id = $6 RETURNING *',
            values: [id_recipient,recipient_name,recipient_address,gift_message,instructions,id]
        };

        try {
            const result = await pool.query(query);
            if (result.rows.length > 0) {
                logger.info(`Gift updated successfully: ${result.rows[0]}`)
                return {
                   success: true,
                   updatedUser:  result.rows[0]
                }
            } else {
                logger.error(`Error in updating Gift`);
                return {
                    success: false,
                }
            }
        } catch (error) {
            logger.error(`Error in update gift: ${error.message}`);
            throw error;
        }
    },

    deleteGift : async (id) => {
        const query = {
            text: 'DELETE FROM gift WHERE id = $1 RETURNING *',
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
                logger.error(`No Gift found with the given ID : ${id}`);
                return {
                    success: false,
                }
            }
        } catch (error) {
            logger.error(`Error in deleting a Gift: ${error.message}`);
            throw error;
        }
    },


}

module.exports =  GiftModel ;
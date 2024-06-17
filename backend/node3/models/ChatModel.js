const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');

const ChatModel = {
    
     getAllChatMediaById : async (id,limit,offset) => {
        const query = {
            text: 'SELECT * FROM chat_room_media WHERE id_chat_room = $1 ORDER BY id ASC LIMIT $2 OFFSET $3',
            values: [id,limit,offset]
        };

      try {  
        const result = await pool.query(query);
        if (result.rows.length === 0) {
           return {
                success: false
               }
        }
        return {
                success: true,
                message: result.rows
               }
      } catch (error) {
        logger.error(`Error fetching from chat_room: ${error.message}`);
        throw error;
      }  
    },

    getAllChatRoomMemberById : async (id,limit,offset) => {
        const query = {
            text: 'SELECT * FROM chat_room_member WHERE id_chat_room = $1 ORDER BY id ASC LIMIT $2 OFFSET $3',
            values: [id,limit,offset]
        };

      try {  
        const result = await pool.query(query);
        if (result.rows.length === 0) {
           return {
                success: false
               }
        }
        return {
                success: true,
                message: result.rows
               }
      } catch (error) {
        logger.error(`Error fetching from chat_room member: ${error.message}`);
        throw error;
      }  
    },

    getAllPostByUserInChatRoom : async (id,limit,offset) => {
        const query = {
            text: 'SELECT * FROM chat_room_media WHERE id_poster = $1 ORDER BY id ASC LIMIT $2 OFFSET $3',
            values: [id,limit,offset]
        };

      try {  
        const result = await pool.query(query);
        if (result.rows.length === 0) {
           return {
                success: false
               }
        }
        return {
                success: true,
                message: result.rows
               }
      } catch (error) {
        logger.error(`Error fetching posts in chatroom  : ${error.message}`);
        throw error;
      }  
    },

    getAllUserChatSingle : async (id,limit,offset,mode) => {

        let queryText;

        if (mode === 1) { // receiver mode
          queryText = 'SELECT * FROM chat_single WHERE id_receiver = $1 ORDER BY id ASC LIMIT $2 OFFSET $3';
        } else { // sender mode
          queryText = 'SELECT * FROM chat_single WHERE id_sender = $1 ORDER BY id ASC LIMIT $2 OFFSET $3';
        }

      try {  
        const result = await pool.query(queryText,[id,limit,offset]);
        if (result.rows.length === 0) {
           return {
                success: false
               }
        }
        return {
                success: true,
                message: result.rows
               }
      } catch (error) {
        logger.error(`Error fetching posts in chat single  : ${error.message}`);
        throw error;
      }  
    },

    getByChatMessage: async (id,message,limit,offset) => {

      let queryText;
      if (mode === 1) { // receiver mode
          queryText = "SELECT * FROM chat_single WHERE id_receiver = $1 AND message LIKE $1 || '%' ORDER BY id ASC LIMIT $2 OFFSET $3";
       } else { // sender mode
          queryText = "SELECT * FROM chat_single WHERE id_sender = $1 AND message LIKE $1 || '%' ORDER BY id ASC LIMIT $2 OFFSET $3";
      }
        
      try {
            const result = await pool.query(queryText,[id,message,limit,offset]);
           if (result.rows.length === 0) {
            logger.error(`No chat message found found`);
             return {
                success: false
               }
           } 
           logger.info(`Chat message found ${message}`);
           return {
                success: true,
                message: result.rows
               }
      } catch (error) {
        logger.error(`Error getting chat message : ${error.message}`);
        throw error;
      }
    },

    getChatRoomByTitle: async (id,title,limit,offset) => {

      const query = {
            text: "SELECT * FROM chat_room WHERE id_creator = $1 AND title LIKE $2 || '%' ORDER BY id ASC LIMIT $3 OFFSET $4", // trigram search
            values: [id,title,limit,offset]
        };
        
      try {
            const result = await pool.query(query);
           if (result.rows.length === 0) {
            logger.error(`No chat found by title`);
             return {
                success: false
               }
           } 
           logger.info(`Chats found ${message}`);
           return {
                success: true,
                message: result.rows
               }
      } catch (error) {
        logger.error(`Error getting chats : ${error.message}`);
        throw error;
      }
    },

    getChatRoomCreatedByUser: async (id,limit,offset) => {

      const query = {
            text: "SELECT * FROM chat_room WHERE id_creator = $1 ORDER BY id ASC LIMIT $2 OFFSET $3", // trigram search
            values: [id,limit,offset]
        };
        
      try {
            const result = await pool.query(query);
           if (result.rows.length === 0) {
            logger.error(`No chatrooms found`);
             return {
                success: false
               }
           } 
           logger.info(`Chat room found ${message}`);
           return {
                success: true,
                message: result.rows
               }
      } catch (error) {
        logger.error(`Error getting chat rooms : ${error.message}`);
        throw error;
      }
    },

    getAllChatRoom : async (limit,offset) => {
       const query = {
        text: 'SELECT * FROM chat_room ORDER BY id ASC LIMIT $1 OFFSET $2',
        values: [limit, offset]
       };
       try {
         const result = await pool.query(query);
         if (result.rows.length === 0) {
            logger.error(`result return failed`);
            return {
                success: false
               }
         } 
         logger.info(`chatroom returned successfuly ${result.rows}`);
         return {
                success: true,
                message: result.rows
               }
       } catch(error) {
        logger.error(`Error fetching result: ${error.message}`);
        throw error;
      }
    },

    getChatRoomByUUID: async (chat_uuid) => {
        const query = {
            text: 'SELECT * FROM chat_room where chatuuid = $1',
            value: [chat_uuid],
         };
        try {
           const result = await pool.query(query);
           if (!result.rows || result.rows.length === 0) {
             return {
                success: false
               }
           } 
            return {
                success: true,
                message: result.rows[0]
               }
        } catch (error) {
             logger.error(`Error fetching chat_room by uuid : ${error.message}`);
             throw error;
        }
    },

    createCountry: async (country_name,country_image_url, country_phone_code) => {
        const query = {
            text: 'INSERT INTO chat_room(id_creator,country_image_url,country_phone_code) VALUES ($1,$2,$3) RETURNING *',
            values: [country_name,country_image_url,country_phone_code],
         };
    	try {
           const result = await pool.query(query);
           if (result.rowCount === 0) {
            logger.error('No rows are inserted');
            return {
                success: false
               }
           } else {
            logger.info(`Country created successfully: ${result.rows}`);
            return {
                success: true,
                message: result.rows[0]
               }
           }
	  } catch (error) { 
        logger.error(`Error in creating Country: ${error.message}`);
        throw error;
      }
    },

    updateCountry: async (country_name,country_image_url, country_phone_code) => {
        const query = {
            text:   'UPDATE country set country_name = $1,country_image_url = $2,country_phone_code = $3 WHERE id = $4 RETURNING *',
            values: [country_name,country_image_url,country_phone_code],
        };  
        try {
        const result = await pool.query(query);
        if (!(result.rows.length > 0)) {
            logger.error(`Error in creating country`);
            return {
                success: false
               }
        } else {
            const updatedRole = result.rows[0];
            logger.info(`Country updated successfully: ${result}`);
            return {
                success: true,
                message: updatedRole.rows[0]
               }
        }
       } catch (error) {   
           logger.error(`Error update role with given ID: ${id}`);
           throw error;
       }
    },

    deleteCountry: async (id) => {
      const query = {
        text:   'DELETE FROM roles WHERE id = $1 RETURNING *',
        values: [id],
      };

      try {
          const result = await pool.query(query);
          if (result.rowCount === 0) {
             logger.error(`Country with id - ${id} not found`);
              return {
                success: false
               }
          } else{
          logger.info(`Successfully deleted country with id : ${id}`);
           return {
                success: true,
                message: result.rows[0]
               }
        }
      } catch (error) {
        logger.error(`Error in deleting country: ${error.message}`);
        throw error;
      }
    },       
}
module.exports = ChatModel;

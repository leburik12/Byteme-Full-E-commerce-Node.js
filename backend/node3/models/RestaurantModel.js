const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');


const RestaurantModel = {

    getAllRestaurant : async (limit,offset) => {
        const query = {
            text: 'SELECT * FROM restaurant_cafe LIMIT $1 OFFSET $2',
            values: [limit,offset]
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
        logger.error(`Error fetching restaurant_cafe: ${error.message}`);
        throw error;
      }  
    },

    getRestaurantById: async (id) => {
        const query = {
            text: `SELECT * FROM restaurant_cafe INNER JOIN store ON restaurant_cafe.id_store = store.id
                   where restaurant_cafe.id = $1`,
            value: [id],
         };
        try {
           const result = await pool.query(query);
           if (!result.rows || result.rows.length === 0) {
            logger.error(`Error fetching restaurant by ID : ${error.message}`);
             return {
                success: false
               }
           } 
            return {
                success: true,
                message: result.rows[0]
               }
        } catch (error) {
             logger.error(`Error getting restaurant by id : ${error.message}`);
             throw error;
        }
    },

     getRestaurantByName: async (name,limit,offset) => {
      const query = {
        text: `SELECT * FROM restaurant_cafe INNER JOIN store ON restaurant_cafe.id_store = store.id 
               WHERE store.name LIKE $1 || '%' ORDER BY id ASC LIMIT $2 OFFSET $3`,
        values: [name,limit,offset]
      };
      try {
            const result = await pool.query(query);
           if (result.rows.length === 0) {
            logger.error(`No cuisine found`);
             return {
                success: false
               }
           } 
           logger.info(`cuisine found by name ${name}`);
           return {
                success: true,
                message: result.rows
               }
      } catch (error) {
        logger.error(`Error getting cuisine by id : ${error.message}`);
        throw error;
      }
    },

    getNearByRestaurants: async (longtiude,latitude,distance,limit,offset) => {
         const query = {
             text: `
                   SELECT store.*, restaurant_cafe.*, store_location.* FROM store_location 
                   INNER JOIN restaurant_cafe ON store_location.id_store = restaurant_cafe.id_store
                   INNER JOIN store ON store_location.id_store = store.id
                   WHERE ST_DWithin(
                       store_location.geom_location,
                       ST_SetSRID(ST_MakePoint($1,$2), 4326),
                       $3
                   ) LIMIT $4 OFFSET $5
             `,
             values: [longtiude,latitude,distance,limit,offset]
         };

        try {
           const result = await pool.query(query);
           if (result.rows.length === 0) {
            logger.error(`No restaurant found within your distance.`);
            return {
                success: false
             }
           }

           logger.info(`restaurants found with in your distance`);
           return {
                success: true,
                message: result.rows
               }
        } catch (error) {
            logger.error(`Error getting nearby restaurants. : , ${error.message}`);
            throw error;
         }
    },

    getRestaurantByName: async (name,limit,offset) => {
        const query = {
           text: `SELECT * FROM `
        }
    },

    createRestaurant : async (id_store,id_cuisine_type,seating_capacity,michelin_stars,ambiance) => {
        const query = {
            text: 'INSERT INTO restaurant(id_store,id_cuisine_type,seating_capacity,michelin_stars,ambiance) VALUES ($1) RETURNING *',
            values: [id_store,id_cuisine_type,seating_capacity,michelin_stars,ambiance],
         };
        
    	try {
           const result = await pool.query(query);
           if (result.rowCount === 0) {
            logger.error('No restaurant are inserted');
            return {
                success: false
               }
           } else {
            logger.info(`restaurant created successfully: ${result.rows}`);
            return {
                success: true,
                message: result.rows[0]
               }
           }
	  } catch (error) { 
        logger.error(`Error in creating restaurant : ${error.message}`);
        throw error;
      }
    },

    updateRestaurant : async (id_store,id_cuisine_type,seating_capacity,michelin_stars,ambiance) => {
        const query = {
            text:   'UPDATE restaurant set id_store =$1 ,id_cuisine_type =$2 ,seating_capacity =$3, michelin_stars=$4,ambiance=$5 WHERE id = $4 RETURNING *',
            values: [id_store,id_cuisine_type,seating_capacity,michelin_stars,ambiance],
        };  
        try {
        const result = await pool.query(query);
        if (!(result.rows.length > 0)) {
            logger.error(`Error in updating restaurant`);
            return {
                success: false
               }
        } else {
            const updatedRole = result.rows[0];
            logger.info(`restaurant updated successfully: ${result}`);
            return {
                success: true,
                message: updatedRole.rows[0]
               }
        }
       } catch (error) {   
           logger.error(`Error updating restaurant with given ID: ${id}`);
           throw error;
       }
    },

    deleteRestaurant : async (id) => {
      const query = {
        text:   'DELETE FROM restaurant WHERE id = $1 RETURNING *',
        values: [id],
      };

      try {
          const result = await pool.query(query);
          if (result.rowCount === 0) {
             logger.error(`restaurant with id - ${id} not found`);
              return {
                success: false
               }
          } else{
          logger.info(`Successfully deleted restaurant with id : ${id}`);
           return {
                success: true,
                message: result.rows[0]
               }
        }
      } catch (error) {
        logger.error(`Error in deleting restaurant : ${error.message}`);
        throw error;
      }
    },  

    getAllCuisine : async (limit,offset) => {
        const query = {
            text: 'SELECT * FROM cuisine_type',
        };
    try {  
        const result = await pool.query(query);
        if (result.rows.length === 0) {
           logger.error(`No Cuisine found`);
           return {
                success: false
               }
        }
         return {
             success: true,
             message: result.rows
        }
      } catch (error) {
        logger.error(`Error fetching cuisine: ${error.message}`);
        throw error;
      }  
    },

    getRestaurantByCuisineId : async (id,limit,offset) => {
        const query = {
            text : `SELECT store.*, restaurant_cafe.*, cuisine_type.* 
                    FROM store
                    JOIN restaurant_cafe ON store.id = restaurant_cafe.id_store 
                    JOIN cuisine_type ON restaurant_cafe.id_cuisine_type = cuisine_type.id 
                    WHERE cuisine_type.id = $1 LIMIT $2 OFFSET $3;`,
            values :  [id,limit,offset]
        }
        try {  
        const result = await pool.query(query);
        if (result.rows.length === 0) {
           logger.error(`No Restaurant found by Cuisine id ${id}`);
           return {
                success: false
               }
        }
         return {
             success: true,
             message: result.rows
        }
      } catch (error) {
        logger.error(`Error fetching restaurant  by cuisine id : ${error.message}`);
        throw error;
      }
    }
}
module.exports = RestaurantModel;

/*
SELECT 
    s.name AS store_name,
    s.image_path,
    r.id AS restaurant_id,
    c.ctname AS cuisine_name,
    l.contact_phone,
    l.contact_email,
    l.floor,
    l.opening_hour,
    l.closing_hour,
    ST_AsText(l.geom_location) AS location
FROM 
    store s
INNER JOIN 
    restaurant_cafe r ON s.id = r.id_store
INNER JOIN 
    cuisine_type c ON r.id_cuisine_type = c.id
LEFT JOIN 
    store_location l ON s.id = l.id_store
WHERE 
    s.name = 'Restaurant Name'; -- Replace 'Restaurant Name' with the actual store name you're looking for
 SELECT 
    s.name AS store_name,
    s.image_path,
    r.id AS restaurant_id,
    c.ctname AS cuisine_name,
    l.contact_phone,
    l.contact_email,
    l.floor,
    l.opening_hour,
    l.closing_hour,
    ST_AsText(l.geom_location) AS location
FROM 
    store s
INNER JOIN 
    restaurant_cafe r ON s.id = r.id_store
INNER JOIN 
    cuisine_type c ON r.id_cuisine_type = c.id
LEFT JOIN 
    store_location l ON s.id = l.id_store
WHERE 
    s.name = 'Restaurant Name'; -- Replace 'Restaurant Name' What is the use of the outer join in the following code in detail ? SELECT 
    s.name AS store_name,
    s.image_path,
    r.id AS restaurant_id,
    c.ctname AS cuisine_name,
    l.contact_phone,
    l.contact_email,
    l.floor,
    l.opening_hour,
    l.closing_hour,
    ST_AsText(l.geom_location) AS location
FROM 
    store s
INNER JOIN 
    restaurant_cafe r ON s.id = r.id_store
INNER JOIN 
    cuisine_type c ON r.id_cuisine_type = c.id
LEFT JOIN 
    store_location l ON s.id = l.id_store
WHERE 
    s.name = 'Restaurant Name'; 
*/

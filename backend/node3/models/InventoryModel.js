search_key_inventory
inventory_bulletlist
upc


const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');

const InventoryModel = {

    filterConditions : {
        id_brand : '=',
        id_product : '=',
        id_storelocation : '=',
        is_auctioned : '=',
        brand : 'LIKE', // Trigram search
        manufacturer : 'LIKE', // Trigram search
        stock_status : '=',
        sku : 'LIKE', // Trigram search
        batch_number : '=',
        restock_threshold : '>=',
        quantity : '=',
        quantity_lt : '<',
        quantity_gt: '>',
        expiration_date: '=',
        expiration_date_lt: '<',
        expiration_date_gt: '>',
        title: 'LIKE', // Trigram search
        description : 'LIKE', // Trigram search
        details : 'LIKE',  // Trigram search
        is_approved : '=', 
        upload_date : '=',
        upload_date_lt : '<',
        upload_date_gt : '>',
        update_date : '=',
        update_date_lt : '<',
        update_date_gt : '>'
    },

    // Function to build the dynamic query
    buildDynamicQuery : (filters) => {
       let baseQuery = 'SELECT * FROM inventory WHERE 1=1';
       const values = [];
       let count = 1;

       Object.keys(filters).forEach((key) => {
          if (filters[key] !== undefined && filters[key] !== null) {
            const condition  = this.filterConditions[key];

            if (key.endsWith('_lt')) {
                baseQuery += ` AND ${key.slice(0,-3)} < $${count}`;
            } else if (key.endsWith('_gt')) {
                baseQuery += ` AND ${key.slice(0,-3)} > $${count}`;
            } else {
                baseQuery += ` AND ${key} ${condition} $${count}`;
            }
            // since indexes don't work if % is apppended as first character
            if (key === 'description') {
                values.push(`%${filters[key]}%`)
            } 
            values.push(condition === 'LIKE' && key !== 'description' ? `${filters[key]}%` : filters[key]);
            count++;
          }
       });
       baseQuery += ` ORDER BY id ASC LIMIT $${count} OFFSET $${count + 1}`;

       return { text: baseQuery, values };
    },
    /*
      const filters = {
        id_brand: 3,
        quantity_gt: 10,
        description: 'organic'
      };
    */
    getInventoryByFilters : async (filters) => {
       const query = this.buildDynamicQuery(filters);

       try {
         const result = await pool.query(query);

         if (result.rows.length === 0) {
            logger.error('No products found by filter');
            return { success: false };
         }
         logger.info('Products found by filter.');
         return { success: true, message: result.rows };
       } catch (error) {
        logger.error(`Error getting products by filter : ${error.message}`);
        throw error;
       }
    },

    getAllInventory : async (limit, offset) => {
        const query = {
            text: 'SELECT * FROM product ORDER BY id ASC LIMIT $2 OFFSET $3',
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
        logger.error(`Error fetching product: ${error.message}`);
        throw error;
      }  
    },

    getInventoryBySearchKey : async ( limit,offset,search_key ) => {
        const query = {
            text : `SELECT  inventory.id, inventory.id_brand, inventory.id_product, inventory.id_storelocation,
                  inventory.is_auctioned, inventory.brand, inventory.manufacturer, inventory.stock_status,
                  inventory.sku, inventory.batch_number, inventory.restock_threshold, inventory.quantity,
                  inventory.expiration_date, inventory.title, inventory.description, inventory.details, inventory.is_approved,
                  inventory.upload_date, inventory.update_date, search_key_inventory.key_name  
                  FROM inventory JOIN search_key_inventory ON inventory.id = search_key_inventory.id_inventory
                  WHERE 
                     search_key_inventory.key_name LIKE $1 || '%'
                  ORDER BY 
                     inventory.id
                  LIMIT $2 OFFSET $3;
                  `,
            values : [search_key,limit,offset]
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
             logger.error(`Error fetching product by search key : ${search_key}`);
             throw error;
         }
    },

    getInventoryById: async (id) => {
        const query = {
            text: 'SELECT * FROM inventory where id = $1',
            value: [id],
         };
        try {
           const result = await pool.query(query);
           if (!result.rows || result.rows.length === 0) {
            logger.error(`Error fetching product by ID : ${error.message}`);
             return {
                success: false
               }
           } 
            return {
                success: true,
                message: result.rows[0]
               }
        } catch (error) {
             logger.error(`Error getting product by id : ${error.message}`);
             throw error;
        }
    },

    createInventory : async (name,ptype,category) => {
        if (!category){
            category=null;
        }
        const query = {
            text: 'INSERT INTO inventory(name,ptype,category) VALUES ($1,$2,$3) RETURNING *',
            values: [name,ptype,category],
         };
    	try {
           const result = await pool.query(query);
           if (result.rowCount === 0) {
            logger.error('No rows are inserted');
            return {
                success: false
               }
           } else {
            logger.info(`product created successfully: ${result.rows}`);
            return {
                success: true,
                message: result.rows[0]
               }
           }
	  } catch (error) { 
        logger.error(`Error in creating product: ${error.message}`);
        throw error;
      }
    },

    updateInventory : async (name,ptype,category) => {
        const query = {
            text:   'UPDATE product set name = $1,ptype = $2,category = $3 WHERE id = $4 RETURNING *',
            values: [name,ptype,category],
        };  
        try {
        const result = await pool.query(query);
        if (!(result.rows.length > 0)) {
            logger.error(`Error in creating product`);
            return {
                success: false
               }
        } else {
            const updatedProduct = result.rows[0];
            logger.info(`product updated successfully: ${result}`);
            return {
                success: true,
                message: updatedProduct.rows[0]
               }
        }
       } catch (error) {   
           logger.error(`Error update product with given ID: ${id}`);
           throw error;
       }
    },

    deleteInventory : async (id) => {
      const query = {
        text:   'DELETE FROM product WHERE id = $1 RETURNING *',
        values: [id],
      };

      try {
          const result = await pool.query(query);
          if (result.rowCount === 0) {
             logger.error(`product with id - ${id} not found`);
              return {
                success: false
               }
          } else{
          logger.info(`Successfully deleted product with id : ${id}`);
           return {
                success: true,
                message: result.rows[0]
               }
        }
      } catch (error) {
        logger.error(`Error in deleting product: ${error.message}`);
        throw error;
      }
    },       
}
module.exports = InventoryModel;

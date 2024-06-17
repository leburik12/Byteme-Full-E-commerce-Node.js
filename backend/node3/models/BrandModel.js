const { pool }  = require('../config/config.js');
const logger = require('../config/logger.js');

const BrandModel = {
    getAllBrand : async (limit,offset) => {
        const query = {
            text: 'SELECT * FROM brand ORDER BY id ASC LIMIT $1 OFFSET $2',
            values: [limit, offset]
        };
        try {
            const result = await pool.query(query);
            if (result.rows.length > 0) {
                logger.info(`brand returned successfuly ${result.rows}`);
                return {
                    success: true,
                    message: 'brand returned successfuly',
                    returnedResult: result.rows
                }
            }
            else {
                logger.error(`brand return failed`);
                return {
                    success: false,
                    message: 'brand return failed'
                }
            }
        } catch (error) {
            logger.error(`Error fetching brand: `,error.message);
            throw error
        }
    },

    getBrandById : async (id) => {
        const query = {
            text: 'SELECT * FROM brand WHERE id = $1',
            value : [id],
        }
        try {
            const result = await pool.query(query);
            if (result.rows.length === 1) {
                logger.info(`brand returned by id ${result.rows[0]}`);
                return {
                    success: true,
                    message: 'brand returned successfully',
                    returnedUser:  result.rows[0]
                 }
            } else {
                logger.error(`No brand found by this ID : ${id}`);
                return {
                    success: false,
                    message: 'Get brand by id failed'
                 }
            }
        } catch(error) {
            logging.error(`Error fetching brand : ${error.message}`)
            throw error;
        }
    },

      getBrandByName: async (name,limit,offset) => {
      const query = {
        text: "SELECT * FROM brand WHERE name LIKE $1 || '%' ORDER BY id ASC LIMIT $2 OFFSET $3",
        values: [name,limit,offset]
      };
      try {
            const result = await pool.query(query);
           if (result.rows.length === 0) {
            logger.error(`No brand found`);
             return {
                success: false
               }
           } 
           logger.info(`brand found by name ${name}`);
           return {
                success: true,
                message: result.rows
               }
      } catch (error) {
        logger.error(`Error getting brand by id : ${error.message}`);
        throw error;
      }
    },

    createBrand : async (name,logo_url) => {
        const query = {
            text: `INSERT INTO brand (name,logo_url)
                 VALUES($1,$2) RETURNING *`,
            values : [name,logo_url]
        };
        try { 
            const result =  await pool.query();
            if (result.rowCount > 0) {
                    logger.info(`brand created successfully: ${result.rows[0]}`);
                    return {
                        success: true,
                        message: 'brand created successfully',
                        returnedResult:  result.rows[0]
                    }
        } else {
            logger.error('Brand creation failed');
            return {
                    success: false,
                    message: `brand creation failed`
               };
            }
        } catch (error) {
            logger.error(`Error in brand creation: ${error.message}`);
            throw error;
        }
    },

    createBrandCategory : async (brand_id,category_id) => {
        const query = {
            text: `INSERT INTO brand_categories (brand_id,category_id)
                 VALUES($1,$2) RETURNING *`,
            values : [brand_id,category_id]
        };
        try { 
            const result =  await pool.query();
            if (result.rowCount > 0) {
                    logger.info(`BrandCategory created successfully: ${result.rows[0]}`);
                    return {
                        success: true,
                        message: 'BrandCategory created successfully',
                        returnedResult:  result.rows[0]
                    }
        } else {
            logger.error('BrandCategory creation failed');
            return {
                    success: false,
                    message: `BrandCategory creation failed`
               };
            }
        } catch (error) {
            logger.error(`Error in BrandCategory creation: ${error.message}`);
            throw error;
        }
    },

    updateBrand : async (id,name,logo_url) => {
        const query = {
            text: `UPDATE brand SET name = $1, logo_url = $2
                   WHERE id = $3`,
            values: [name,logo_urlid] 
        };
        try {
            const result = await pool.query(query);
            if (result.rows.length !== 1) {
                logger.error(`Error in creating district`);
                return 0;
            } else if (result.rows.length === 1) {
                logger.info(`district updated successfully: ${result.rows[0]}`);
                return result.rows
            }
        } catch (error) {
            logger.error(`Error in district update: ${error.message}`);
            throw error;
        }
    },

    deleteBrand : async (id) => {
        const query = {
            text: 'DELETE FROM brand WHERE id = $1 RETURNING *',
            values: [id]
        };

        try {
             const result = await pool.query(query);
             if (!result.rowCount > 0) {
                logger.error(`No brand found with the given ID : ${id}`);
                return 0;
             } 
             logger.info(`Deleted Successful: `,result.rows[0]);
             return result.rows

        } catch (error) {
            logger.error(`Error in deleting a brand: ${error.message}`);
            throw error 
        }
    }
}

module.exports = BrandModel;
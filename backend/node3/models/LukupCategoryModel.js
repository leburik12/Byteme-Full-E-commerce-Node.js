const { pool } = require('../config/config.js');
const logger = require('../config/logger.js');
const districtUtils = require('../utility/dbUtils.js');


const CategoryModel = {

    getAllCategoryRecusively : async() => {
       const query = {
        text: `
          with recursive category_tree as (
  select 
        id,
        id_parent_category,
        name,
        type,
        media_url,
        upload_date,
        update_date,insert_random_user
        json_build_object(
          'id', id,
            'name', name,
            'type', type,
            'media_url', media_url,
            'upload_date', upload_date,
            'update_date', update_date,
            'subcategories', '[]'::json
        ) as category_json
  from lukup_category 
   where id_parent_category is null
   union all

   select 
        c.id,
        c.id_parent_category,
        c.name,
        c.type,
        c.media_url,
        c.upload_date,
        c.update_date,
      json_build_object(
        'id', c.id,
            'name', c.name,
            'type', c.type,
            'media_url', c.media_url,
            'upload_date', c.upload_date,
            'update_date', c.update_date,
            'subcategories', '[]'::json
      ) as category_json
      from lukup_category c 
      inner join 
      category_tree ct on c.id_parent_category = ct.id
)
select 
  json_build_object (
        'id', ct.id,
        'name', ct.name,
        'type', ct.type,
        'media_url', ct.media_url,
        'upload_date', ct.upload_date,
        'update_date', ct.update_date,
        'subcategories', (
          select 
             json_agg(sub_ct.category_json)
             from category_tree sub_ct
             where sub_ct.id_parent_category = ct.id
        )
) as category_json 
from category_tree ct
where ct.id_parent_category is null;  
        `
       };

       try {
          const result = await pool.query(query);
          if (result.rows.length === 0) {
            logger.error('Recursive iteration in category resulted in failure');
            return {
                success: false
            }
          } logger.info('lukupCategory recursive iteration successfuly ');
            return {
              success: true, 
              message: result.rows
            };
       } catch (error) {
        logger.error(`Error fetching recursive category: ${error.message}`);
        throw error;
       }
    },

    getFirstChildrenById: async(id) => {
      const query = {
         text: `SELECT c.id,c.id_parent_category,c.name FROM 
                lukup_category c WHERE c.id_parent_category = $1 ORDER BY c.id ASC`,
         values: [id],
      }

      try {
        const results = await pool.query(query);
        if (results.rows.length === 0) {
          logger.error('category return failed');
          return { success : false, errorCode : 0 }  // error Code 0 indicates empty result from the database
        }
      logger.info(`results returned successfuly ${results.rows}`);
      return {
        success: true,
        result: results.rows
       }
      } catch (error) {
        logger.error(`Invalid Parent Category ID`);
        return {
          success: false
        }
      }
    },

    getMainParentCategories : async() => {
       const query = {
         text: `SELECT c.id,c.id_parent_category,c.name FROM 
                lukup_category c WHERE c.id_parent_category IS NULL ORDER BY c.id ASC`
      }

      try {
        const results = await pool.query(query);
        if (results.rows.length === 0) {
          logger.error('Main Parent category return failed');
          return { successs: false }
        }
      logger.info(`results returned successfuly ${results.rows}`);
      return {
        success: true,
        result: results.rows
       }
      } catch (error) {
        logger.error(`Invalid Main Parent Category ID`);
        return {
          success: true,
          result:  results.rows
        }
      }
    },

     getCategoryRecusivelyById : async(id) => {
       const query = {
        text: `
          WITH RECURSIVE category_hierarchy AS (
  SELECT 
    id,
    id_parent_category,
    name,
    type,
    media_url,
    upload_date,
    update_date,
    jsonb_build_object(
      'id', id,
      'name', name,
      'type', type,
      'media_url', media_url,
      'upload_date', upload_date,
      'update_date', update_date,
      'subcategories', '[]'::jsonb
    ) AS category_json
  FROM lukup_category
  WHERE id = $1 

  UNION ALL

  SELECT 
    c.id,
    c.id_parent_category,
    c.name,
    c.type,
    c.media_url,
    c.upload_date,
    c.update_date,
    jsonb_build_object(
      'id', c.id,
      'name', c.name,
      'type', c.type,
      'media_url', c.media_url,
      'upload_date', c.upload_date,
      'update_date', c.update_date,
      'subcategories', '[]'::jsonb
    ) AS category_json
  FROM lukup_category c
  JOIN category_hierarchy p ON c.id_parent_category = p.id
)

SELECT 
  id,
  jsonb_set(
    category_json,
    '{subcategories}',
    COALESCE(
      (
        SELECT jsonb_agg(ch.category_json)
        FROM category_hierarchy ch
        WHERE ch.id_parent_category = category_hierarchy.id
      ),
      '[]'::jsonb
    )
  ) AS category_json FROM category_hierarchy WHERE id=$2; 
        `,
        values:[id,id]
       };

       try {
          const result = await pool.query(query);
          if (result.rows.length === 0) {
            logger.error('Recursive iteration in category by ID resulted empty');
            return {
                success: false
            }
          } 
          logger.info('lukupCategory recursive iteration by ID successfuly ');
            return {
              success: true, 
              message: result.rows
            };
       } catch (error) {
        logger.error(`Error fetching recursive category by ID: ${error.message}`);
        throw error;
       }
    },

    getAllCategory: async () => {
       const query = {
        text: 'SELECT * FROM lukup_category',
       };
       try {
         const lukupCategory = await pool.query(query);
         if (lukupCategory.rows.length === 0) {
            logger.error(`lukupCategory return failed`);
            return 0
         } 
         logger.info(`lukupCategory returned successfuly ${lukupCategory.rows}`);
         return lukupCategory
       } catch(error) {
        logger.error(`Error fetching lukupCategory: ${error.message}`);
        throw error;
     }
    },

    /*  implement recursive common table expressino */
    getCategoryById : async (id) => {
       const query = {
         text: 'SELECT * FROM lukup_category WHERE id = $1',
         value : [id]
       };

       try { 
         const result = await pool.query(query);
         if (result.rows.length !== 1) {
             logger.error(`No lukup_category found by ID : ${id}`);
             return 0;
         } else if (result.rows.length === 1) {
            logger.info(`lukup_category returned by id ${result.rows[0]}`);
            return result.rows[0];
         }
       } catch (error) {
        logger.error(`Error fetching lukup_category : ${error.message}`);
        throw error;
       }
    },

    createCategory: async (id_parent_category,name,type,media_url) => {
        const query = {
            text: `INSERT INTO lukup_category (id_parent_category,name,type,media_url)
            VALUES ($1,$2,$3,$4) RETURNING *`,
            values:[id_parent_category,name,type,media_url]
        };
        try {
            const result = await pool.query(query);
            if (!(result.rowCount > 0)) {
                logger.error(`Error in lukupCategory creation`);
                return 0;
            }
            logger.info(`lukupCategory created successfully: ${result.rows[0]}`)
            return result
        } catch (error) {
            logger.error(`Error in lukupCategory creation: ${error.message}`);
            throw error;
        }
    },

    updateCategory : async (id,id_parent_category,name,type,media_url) => {
        const query = {
            text: `UPDATE lukup_category SET id_parent_category = $1, name = $2, type = $3, media_url = $4 
                   WHERE id = $5`,
            values: [id_parent_category,name,type,media_url,id] 
        };
        try {
            const result = await pool.query(query);
            if (result.rows.length !== 1) {
                logger.error(`Error in creating LukupCategory`);
                return 0;
            } else if (result.rows.length === 1) {
                logger.info(`LukupCategory updated successfully: ${result.rows[0]}`);
                return result.rows
            }
        } catch (error) {
            logger.error(`Error in LukupCategory update: ${error.message}`);
            throw error;
        }
    },

    deleteCategory: async (id) => {
        const query = {
            text: 'DELETE FROM lukup_category WHERE id = $1 RETURNING *',
            values: [id]
        };

        try {
             const result = await pool.query(query);
             if (!result.rowCount > 0) {
                logger.error(`No lukup_category found with the given ID : ${id}`);
                return 0;
             } 
             logger.info(`Deleted Successful: `,result.rows[0]);
             return result.rows

        } catch (error) {
            logger.error(`Error in deleting a lukup_category: ${error.message}`);
            throw error 
        }
    },
    
};
module.exports = CategoryModel;


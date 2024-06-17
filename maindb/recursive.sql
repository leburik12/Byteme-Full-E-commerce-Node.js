/*
WITH RECURSIVE category_hierarchy AS (
  -- Anchor member: select the root categories
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
      'id_parent_category',id_parent_category,
      'name', name,
      'type', type,
      'media_url', media_url,
      'upload_date', upload_date,
      'update_date', update_date,
      'children', '[]'::jsonb
    ) AS category_json
  FROM 
    lukup_category
  WHERE 
    id_parent_category IS NULL
  
  UNION ALL
  
  -- Recursive member: select subcategories and build the JSON structure
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
      'id_parent_category',c.id_parent_category,
      'name', c.name,
      'type', c.type,
      'media_url', c.media_url,
      'upload_date', c.upload_date,
      'update_date', c.update_date,
      'children', '[]'::jsonb
    ) AS category_json
  FROM 
    lukup_category c
  INNER JOIN 
    category_hierarchy ch ON ch.id = c.id_parent_category
)
-- Aggregate the JSON objects into the final hierarchical JSON structure
SELECT 
  jsonb_pretty(
    jsonb_agg(ch.category_json)
    FILTER (WHERE ch.id_parent_category IS NULL)
  ) AS hierarchy
FROM (
  SELECT 
    ch1.id,
    ch1.id_parent_category,
    ch1.name,
    ch1.type,
    ch1.media_url,
    ch1.upload_date,
    ch1.update_date,
    jsonb_set(
      ch1.category_json,
      '{children}',
      (
        SELECT 
          jsonb_agg(ch2.category_json)
        FROM 
          category_hierarchy ch2
        WHERE 
          ch2.id_parent_category = ch1.id
      )
    ) AS category_json
  FROM 
    category_hierarchy ch1
) ch;
WITH RECURSIVE category_hierarchy AS (
  -- Anchor member: select the root categories
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
      'id_parent_category',id_parent_category,
      'name', name, 
      'type', type,
      'media_url', media_url,
      'upload_date', upload_date,
      'update_date', update_date,
      'children', '[]'::jsonb
    ) AS category_json
  FROM 
    lukup_category
  WHERE 
    id_parent_category IS NULL
  UNION ALL
  -- Recursive member: select subcategories, populate children and add back to CTE
  SELECT 
    c.id,
    c.id_parent_category,
    c.name,
    c.type,
    c.media_url,
    c.upload_date,
    c.update_date,
    jsonb_set(
      ch1.category_json,  -- Use ch1.category_json (from outer CTE)
      '{children}',
      (
        SELECT 
          jsonb_agg(ch2.category_json)
        FROM 
          category_hierarchy ch2
        WHERE 
          ch2.id_parent_category = ch1.id
      )
    ) AS category_json
  FROM 
    lukup_category c
  INNER JOIN 
    category_hierarchy ch1 ON ch1.id = c.id_parent_category
)
-- Aggregate the JSON objects into the final hierarchical JSON structure
SELECT 
  jsonb_pretty(
    jsonb_agg(ch.category_json)
    FILTER (WHERE ch.id_parent_category IS NULL)
  ) AS hierarchy
FROM category_hierarchy ch;
*/
WITH RECURSIVE category_hierarchy AS (
  -- Anchor member: selects all top-level categories
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
  WHERE id_parent_category IS NULL

  UNION ALL

  -- Recursive member: selects subcategories and builds their JSON
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

-- Final step to aggregate subcategories
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
  ) AS category_json
FROM category_hierarchy
WHERE id_parent_category IS NULL;




WITH RECURSIVE category_hierarchy AS (
  -- Anchor member: select the specified root category
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
  WHERE id = 5  -- Replace <SPECIFIC_CATEGORY_ID> with the desired category ID

  UNION ALL

  -- Recursive member: select subcategories and build their JSON
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


WITH RECURSIVE category_hierarchy AS (
    -- Base case: Start with the given parent category
    SELECT id, id_parent_category, name, type, media_url, upload_date, update_date,
           ARRAY[id]::INTEGER[] AS path
    FROM lukup_category
    WHERE id = 1

    UNION ALL

    -- Recursive case: Fetch children of the current category
    SELECT c.id, c.id_parent_category, c.name, c.type, c.media_url, c.upload_date, c.update_date,
           ch.path || c.id
    FROM lukup_category c
    JOIN category_hierarchy ch ON c.id_parent_category = ch.id[ch.path->length]
)
SELECT jsonb_build_object(
         'categories', jsonb_agg(category_to_json(category))
       )
FROM (
    SELECT *, jsonb_build_object('name', name, 'type', type, 'mediaUrl', media_url, 'uploadDate', upload_date, 'updateDate', update_date) AS category
    FROM category_hierarchy
) subquery;



WITH RECURSIVE category_hierarchy AS (
  -- Anchor member: select the specified root category
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
  WHERE id = 5  -- Replace <SPECIFIC_CATEGORY_ID> with the desired category ID

  UNION ALL

  -- Recursive member: select subcategories and build their JSON
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

-- Final step to aggregate subcategories
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
  ) AS category_json
FROM category_hierarchy
WHERE id = 5; 


with recursive category_tree as (
  select 
        id,
        id_parent_category,
        name,
        type,
        media_url,
        upload_date,
        update_date,
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


















WITH RECURSIVE category_hierarchy AS (
  -- Anchor member: selects all top-level categories
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
  WHERE id_parent_category IS NULL

  UNION ALL

  -- Recursive member: selects subcategories and builds their JSON
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

-- Final step to aggregate subcategories
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
  ) AS category_json
FROM category_hierarchy
WHERE id_parent_category IS NULL;

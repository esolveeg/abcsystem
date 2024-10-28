
-- name: IconsCreateUpdateBulk :many
select 
    icon_id ,
    icon_name ,
    icon_content
FROM  icons_create_update_bulk(sqlc.arg(icons_name)::text[] , sqlc.arg(icons_contents)::text[]);




-- name: IconsInputList :many
select 
    icon_id ,
    icon_name ,
    icon_content
   FROM 
 icons  ;




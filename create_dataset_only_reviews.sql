CREATE TABLE unignhaupka.oal_scp_review_analysis AS (
    WITH 
    	oal_review_analysis AS (
	        SELECT doi, item_id, item_title, UNNEST(item_type) AS type, pagecount, source_ref_count, source_title, pubyear
	        FROM fiz_openalex_bdb_20250201.items
	        WHERE pubyear BETWEEN 2018 AND 2024 AND 'article' = ANY(item_type)
    	),
    	scp_review_analysis AS (
	        SELECT doi, item_title, UNNEST(item_type) AS type, pagecount, ref_count, source_title, pubyear
	        FROM scp_b_202501.items
	        WHERE pubyear BETWEEN 2018 AND 2024 AND 'Review' = ANY(item_type)
    	)
    SELECT oal.doi, oal.item_id AS openalex_id, oal.item_title, oal.type AS oal_type, scp.type AS scp_type, oal.pagecount, oal.source_ref_count, oal.source_title, oal.pubyear
    FROM oal_review_analysis AS oal
    JOIN scp_review_analysis AS scp
        ON oal.doi = scp.doi
    WHERE oal.type = 'article' AND scp.type = 'Review'
)
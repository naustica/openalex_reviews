CREATE TABLE unignhaupka.oal_scp_corpus_2018_2024 AS (
    WITH 
    	oal_review_analysis AS (
	        SELECT doi, item_id, item_title, UNNEST(item_type) AS type, pagecount, source_ref_count, source_title, pubyear, source_type
	        FROM fiz_openalex_bdb_20250201.items
	        WHERE pubyear BETWEEN 2018 AND 2024
    	),
    	scp_review_analysis AS (
	        SELECT doi, item_title, UNNEST(item_type) AS type, pagecount, ref_count, source_title, pubyear
	        FROM scp_b_202501.items
	        WHERE pubyear BETWEEN 2018 AND 2024
    	)
    SELECT oal.doi, oal.item_id AS openalex_id, oal.item_title, oal.type AS oal_type, scp.type AS scp_type, oal.pagecount, oal.source_ref_count, oal.source_title, oal.pubyear
    FROM oal_review_analysis AS oal
    JOIN scp_review_analysis AS scp
        ON oal.doi = scp.doi
    WHERE oal.source_type = 'journal'
)
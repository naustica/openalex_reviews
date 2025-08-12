select oal.item_id, doi, item_title
from fiz_openalex_bdb_20250201.items oal
join fiz_openalex_bdb_20250201.abstracts AS a
    on a.item_id = oal.item_id
where 'article' = any(item_type) and pubyear between 2018 and 2024
	and (lower(a.abstract_plain_text) ~ '(\sthis\s|systematic\s|umbrella\s|bibliographic\s|literature\s|scoping\s|comprehensive\s|mini-)review'
	or lower(item_title) ~ '(\sa\s|systematic\s|umbrella\s|bibliographic\s|literature\s|scoping\s|comprehensive\s|mini-)review')
order by random()
limit 50
	
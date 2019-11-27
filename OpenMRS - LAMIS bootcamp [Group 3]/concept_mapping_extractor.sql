USE chcmadalla;

SELECT DISTINCT concept_id, conceptname, NAME AS form_name FROM (
SELECT 
	ob.concept_id,
	(SELECT cn.name FROM concept_name AS cn WHERE cn.concept_id=ob.concept_id AND locale='en' LIMIT 1) AS conceptname,
	
	CASE WHEN ob.value_coded IS NOT NULL THEN
		(SELECT cn.name FROM concept_name AS cn WHERE cn.concept_id=ob.value_coded AND locale='en' LIMIT 1)
	ELSE
		COALESCE(CONVERT(ob.value_datetime, DATE), ob.value_numeric, ob.value_text)
	END  AS conceptvalue,
		
	#ob.encounter_id,
	#en.encounter_id,
	#en.form_id,
	fm.name
FROM obs AS ob
LEFT JOIN encounter AS en ON ob.encounter_id=en.encounter_id
LEFT JOIN form AS fm ON en.form_id=fm.form_id
) AS dt
ORDER BY NAME, concept_id
#order by ob.concept_id
;
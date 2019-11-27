DROP TABLE IF EXISTS temp_all_obs;
CREATE TABLE temp_all_obs AS
SELECT
  `obs`.`obs_id` AS `obs_id`,
  `obs`.`person_id` AS `person_id`,
  `pid1`.`identifier` AS `PEPFAR_ID`,
  `pid2`.`identifier` AS `HOSP_ID`,
  `obs`.`obs_datetime` AS `VISIT_DATE`,
  `form`.`name` AS `PMM_FORM`,
  ##CONCAT(IFNULL(`prsn1`.`given_name`,''),' ',IFNULL(`prsn1`.`middle_name`,''),' ',IFNULL(`prsn1`.`family_name`,'')) AS `PROVIDER`,
  `obs`.`concept_id` AS `concept_id`,
  `cn1`.`name` AS `VARIABLE_NAME`,
  CAST(COALESCE(GROUP_CONCAT(`cn2`.`name` SEPARATOR ','),`obs`.`value_numeric`,`obs`.`value_datetime`,`obs`.`value_text`) AS CHAR CHARSET utf8) AS `VARIABLE_VALUE`,
  get_concept_name(`obs`.`value_coded`) AS value_coded_value, `obs`.`value_coded`  AS `value_coded_id`,
  CONCAT(IFNULL(`prsn`.`given_name`,''),' ',IFNULL(`prsn`.`middle_name`,''),' ',IFNULL(`prsn`.`family_name`,'')) AS `ENTERED_BY`,
  `obs`.`date_created` AS `DATE_ENTERED`,
  `obs`.`creator` AS `creator`,
  `obs`.`encounter_id`      AS `encounter_id`,
  `obs`.`obs_group_id`      AS `obs_group_id`,
  `obs`.`uuid`              AS `OBS_UUID`,
  `form`.`form_id`          AS `form_id`,
  ##`encounter`.`provider_id` AS `provider_id`,
  `obs`.`location_id`       AS `location_id`
FROM ((((((((((`obs`
            LEFT JOIN `patient`
              ON ((`patient`.`patient_id` = `obs`.`person_id`)))
           LEFT JOIN `patient_identifier` `pid1`
             ON (((`pid1`.`patient_id` = `patient`.`patient_id`)
                  AND (`pid1`.`voided` = 0)
                  AND (`pid1`.`identifier_type` = 4))))
          LEFT JOIN `patient_identifier` `pid2`
            ON (((`pid2`.`patient_id` = `patient`.`patient_id`)
                 AND (`pid2`.`voided` = 0)
                 AND (`pid2`.`identifier_type` = 3))))
         LEFT JOIN `concept_name` `cn1`
           ON (((`obs`.`concept_id` = `cn1`.`concept_id`)
                AND (`cn1`.`locale_preferred` = 1)
                AND (`cn1`.`locale` = 'en')
                AND (`cn1`.`voided` = 0))))
        LEFT JOIN `concept_name` `cn2`
          ON (((`obs`.`value_coded` = `cn2`.`concept_id`)
               AND (`cn2`.`locale_preferred` = 1)
               AND (`cn2`.`locale` = 'en')
               AND (`cn1`.`voided` = 0))))
       LEFT JOIN `encounter`
         ON (((`encounter`.`encounter_id` = `obs`.`encounter_id`)
              AND (`encounter`.`voided` = 0)
              AND (`obs`.`voided` = 0))))
      LEFT JOIN `form`
        ON (((`encounter`.`form_id` = `form`.`form_id`)
             AND (`form`.`retired` = 0))))
     LEFT JOIN `users`
       ON ((`users`.`user_id` = `obs`.`creator`)))
    LEFT JOIN `person_name` `prsn`
      ON (((`prsn`.`person_id` = `users`.`person_id`)
           AND (`prsn`.`voided` = 0))))
   #LEFT JOIN `person_name` `prsn1`  ON (((`prsn1`.`person_id` = `encounter`.`provider_id`)  AND (`prsn1`.`voided` = 0)))
   )
WHERE (`obs`.`voided` = 0)
GROUP BY `obs`.`encounter_id`,`obs`.`concept_id`,`obs`.`obs_group_id`
ORDER BY `patient`.`patient_id`,`obs`.`obs_group_id`,`encounter`.`form_id`;
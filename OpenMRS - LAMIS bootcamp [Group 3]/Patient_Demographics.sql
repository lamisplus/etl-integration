DROP TABLE IF EXISTS temp_all_demographics;

set @uniqueid = 3;
set @hospitalnum = 6;
set @ancnum = 4;
set @eidnum = 7;
set @clientnum = 8;

CREATE TABLE temp_all_demographics AS 
SELECT `patient`.`patient_id` AS `patient_id`,
  `get_patient_identifier`(`patient`.`patient_id`,@uniqueid) AS `Unique_Id`,
  `get_patient_identifier`(`patient`.`patient_id`,@hospitalnum) AS `Hospital_No`,
  `get_patient_identifier`(`patient`.`patient_id`,@ancnum) AS `ANC_number`,
  `get_patient_identifier`(`patient`.`patient_id`,@eidnum) AS `EID_No`,
  `get_patient_identifier`(`patient`.`patient_id`,@clientnum) AS `Client_No`,
  `person_name`.`family_name` AS `surname`,
  `person_name`.`given_name`, `person_name`.`middle_name`,
  `person`.`birthdate`,
  `person`.`gender` AS `gender`,  
  `person_address`.`address1`, `person_address`.`address2`,  
  `person_address`.`state_province` AS `state`,
  `person_address`.`city_village` AS `lga`,
  `person`.`date_created`,`pp1`.`date_enrolled`  
  FROM ((((`patient`
             LEFT JOIN `person`
               ON (((`patient`.`patient_id` = `person`.`person_id`)
                    AND (`person`.`voided` = 0))))            
        LEFT JOIN `person_name`
          ON (((`patient`.`patient_id` = `person_name`.`person_id`)
               AND (`person_name`.`voided` = 0))))
       LEFT JOIN `person_address`
         ON (((`patient`.`patient_id` = `person_address`.`person_id`)
              AND (`person_address`.`voided` = 0))))
     LEFT JOIN `patient_program` `pp1`
       ON (((`pp1`.`patient_id` = `patient`.`patient_id`)
            AND (`pp1`.`program_id` = 3)
            AND (`pp1`.`voided` = 0))));
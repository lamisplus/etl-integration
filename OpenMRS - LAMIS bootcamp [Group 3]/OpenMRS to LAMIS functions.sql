DELIMITER $$

USE ghminna $$

DROP FUNCTION IF EXISTS `get_concept_name`$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_concept_name`(conceptid INT) RETURNS VARCHAR(100) CHARSET latin1
BEGIN
    
    RETURN (SELECT NAME FROM  concept_name 
		WHERE concept_id = conceptid 
		AND locale = 'en' AND locale_preferred = 1
		LIMIT 1);

    END$$
    
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
DELIMITER $$

USE ghminna $$

DROP FUNCTION IF EXISTS `get_form_name`$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_form_name`(formid INT) RETURNS VARCHAR(100) CHARSET latin1
BEGIN
	RETURN (SELECT NAME FROM form WHERE form_id = formid limit 1);
    END$$
    
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
DELIMITER $$

USE ghminna$$

DROP FUNCTION IF EXISTS `get_patient_identifier`$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_patient_identifier`(patientid INT, identifierType INT) RETURNS VARCHAR(100) CHARSET latin1
BEGIN
	RETURN (SELECT identifier FROM patient_identifier WHERE patient_id = patientid AND identifier_type = identifierType limit 1);
    END$$
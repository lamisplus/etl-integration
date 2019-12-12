# Definition of ETL 
**ETL** is short for **Extract, Transform, Load**; three database functions that are combined into one tool to pull data out of one database and place it into another database. Here, the ETL process ensures seamless data transformation from OpenMRS to LAMIS. 

* **Extract** is the process of reading data from a database. In this stage, the data is collected, often from multiple and different types of sources. One of the sources is here is OpenMRS.
* **Transform** is the process of **converting the extracted data** from its previous form into the form it needs to be in so that it can be placed into another database. Transformation occurs by using rules and lookup tables or by combining the data with other data. 
* **Load** is the process of **writing** the data into the target database. Here, the target database is LAMIS.

# Process Layout:
1. Setup the ETL process
2. Run the ETL process
3. Add a new ETL process for a new query.

# Extraction
**Steps for Extraction from ETL INTEGRATION tool:**
* Click on the ETL Integration UI
* Setup the connection setting (if none is already set)
* Specify source and destination of connection setting
* Click “**Extract**” to do data extraction and select the “**Source**” and “**Destination**” of the connection setting on the home page
* Select the fields/forms (concept name) on the drop down and match to the would be mapped contents
* Select the appropriate connection drivers of ODBC, JDBC and API and fill in the corresponding details and credentials of the respective connections
* Click Save.
* This automatically saves the connection as .xml file in the application directory 
* Click the “**Transform**” tab.
* Notice this new ETL is now listed in the **Transforms** web part.


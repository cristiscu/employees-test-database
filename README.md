## Employees Test Database

***Employees*** (or ***EmployeesQX***, to avoid a name conflict with other samples) is a very simple database to be used for testing in relational database systems. It is inspired from similar small databases included in Oracle, MySQL or other database systems over the years.

This shared repository makes it easy to download ready-to-use database files, when supported. Or SQL scripts, to be run in a database admin tool, to create and populate the few tables with data.

## Supported Databases

Before loading and running the SQL scripts with a specific tool, you may already have to create manually a database, user or schema, with proper access rights, and log in with the new credentials. If that's the case, comment-out the first few lines related to these database objects. Checking and dropping existing tables can be also ignored, for a brand new database.

 - **Snowflake** - added in March 2022. Can use the Snowflake web UI to run the script file. It creates the database, the tables and other database objects, foreign key constraints, and populates the tables. You should be able to connect with either username/password, or SSO, Key-Pair or OAuth.
 - **Oracle** -  since version 10g Rel1 to 18c. Can use the free SQL Developer to create a new EmployeesQX username/schema with enough access rights, then use it to run the script. Comment-out the first few lines, when you do this.
 - **IBM Db2** - since version 10.5 to 11.1. Can use DB2 Lite on Cloud for a free limited remote service, used for development and evaluation. You'll have to confirm renewal every 30 days, or the database is deleted automatically afetr 60 days. Run the script after you create the remote database.
 - **Microsoft SQL Server** -  since version 2008 to 2017. Can use the free SSMS (SQL Server Management Studio) to manually create an EmployeesQX database first, with appropriate access rights.
 - **Microsoft Azure Database** - you need to create an EmployeesQX public database in Microsoft's cloud first. Unless you use a free trial, be aware you will likely be charged a fee for its usage. The script is similar to the one for Microsoft SQL Server.
 - **Microsoft SQL Server CE** - SQL Compact Edition is no longer maintained by Microsoft, but you can still create and use perfectly fine SQL CE databases. Rather that running the SQL script, open and use directly the SDF file included in this repository. All Data Xtractor applications ship with this ready-to-use database sample.
 - **Microsoft Access** - since version 2007 to 2019. Microsoft Access does not support SQL creation scripts, but you can open directly one of the ready-to-use MDB or ACCDB database files included in this repository. All Data Xtractor applications ship with these ready-to-use database samples.
 - **PostgreSQL** -  since version 8.4 to 11. Can use the free pgAdmin application to create an EmployeesQX database and run the creation script. There is a separate script for v8.4, as it has some other specific old data types.
 - **Amazon Redshift** - Redshift was a fork from PostgreSQL 8.0.2, but it changed much since. Create one cluster with an employeesqx public database, then use SQL Workbench to run the script. Be aware that, unless you use a free trial, you will be charged for the cloud database. Select the less expensive plan, with just one node, to do some tests.
 - **MySQL** - since version 5.5 to 8.0. Can use the free MySQL Workbench to load and run the script locally, or phpMyAdmin for remote databases. Connect with the root admin username or create your own.
 - **Amazon Aurora** - Aurora uses an optimized MySQL 5.6/5.7 database at this time, and you will be charged for it. Create a public database in Amazon's cloud, with the smallest cluster. Then connect through MySQL Workbench and run the script.
 - **MariaDB** - since v5.5 to 10.4. Can use the free HeidiSQL to run the creations script.
 - **SAP/Sybase ASE** - since v16 to v17. ASE (Active Server Enterprise) was acquired by SAP from Sybase a while ago. 
 - **SAP/Sybase SQL Anywhere** - since v16 to v17. As for ASE, SQL Anywhere was Sybase, and now it is SAP's. Can use their SQL Central tool to load and run the script. As an alternative, you can directly connect to the ready-to-use DB database file. There are specific files for each version.
 - **SQLite** - should support all version 3 releases. Rather that running the SQL script, use directly the DB file included in this repository. All Data Xtractor applications ship with this ready-to-use database sample.
 - **Firebird** - since v2.5 to 3. You can use FlameRobin to populate the database through the script. Or access directly the ready-to-use FDB file.  

***Please let me know when/if you create a similar SQL script for a new database type, to add it to the list and share it for free with the community.***

## Data Model

The database is also used for automated tests in my [**Data Xtractor applications**](https://data-xtractor.com/knowledgebase/employees-database-sample/), including **Model Xtractor**, **Query Xtractor** and **Visual Xtractor**. The apps also include the SQL creation scripts in the setup. Employees ready-to-use database files are used as SQLite and Microsoft SQL CE samples.

Following database diagram is from Data Xtractor. It shows all tables and views of an Employees Oracle 11g database, with lookup data on the emp (Employees) table.

![enter image description here](https://data-xtractor.com/wp-content/uploads/employees-test-database.png)

## Tables and Views

The database exposes a one-to-many relationship between two main tables: **dept** (Departments) and **emp** (Employees). These tables have been used way back by Oracle, in its original *scott/tiger* sample (*scott* username/schema, with *tiger* password). 

Each employee - except for KING, the president - has one manager. This is implemented as a reflexive one-to-one/zero relationship. The **Managers** view shows all pairs of Manager-Employee names.

A small **proj** (Projects) table has been added for time-series and Gantt diagram testing. One employee may be involved in one or more projects over time.

Finally, one **datatypes** table (displayed collapsed here before) is specific to each database system, as it includes particular data types. One single record allows us to check if database types are processed correctly.

## Table Data

INSERT SQL statements to populate tables with data are all included in the creation scripts. We kept it small and simple, so there is only one single script per any database. Each table was populated with just a few rows, just to allow some simple or complex SQL queries to be run against:

 - **dept** - 4 entries, with departments 10, 20, 30 and 40.
 - **emp** - 14 employee entries, as in the previous image, with lookup data.
 - **proj** - 15 project entries, for dates between June-July 2005.
 - **datatypes** - one single entry, to test database-specific data type values.

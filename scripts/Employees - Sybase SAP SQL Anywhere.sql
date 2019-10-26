-- EmployeesQX - Sybase SAP SQL Anywhere.sql
-- Use SQL Central or another Sybase/SAP SQL Anywhere administrator.
-- Create an EmployeesQX database, then run this script. 

DROP VIEW IF EXISTS "Managers";
DROP MATERIALIZED VIEW IF EXISTS "Materialized";
DROP TABLE IF EXISTS "datatypes";
DROP TABLE IF EXISTS "proj";
DROP TABLE IF EXISTS "emp";
DROP TABLE IF EXISTS "dept";

CREATE TABLE "dept" (
   "DEPTNO"         integer NOT NULL,
   "DNAME"          varchar(20) NOT NULL,
   "LOC"            varchar(20) NOT NULL,
   
   PRIMARY KEY      ("DEPTNO")
);

COMMENT ON TABLE "dept" IS 'All company''s departments, with employees';
COMMENT ON COLUMN "dept"."DEPTNO" IS 'Department''s identification number';
COMMENT ON COLUMN "dept"."DNAME" IS 'Name of the current department';
COMMENT ON COLUMN "dept"."LOC" IS 'Location of the current department';

INSERT INTO "dept" VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO "dept" VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO "dept" VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO "dept" VALUES (40, 'OPERATIONS', 'BOSTON');


CREATE TABLE "emp" (
   "EMPNO"          integer NOT NULL,
   "ENAME"          varchar(20) NOT NULL,
   "JOB"            varchar(20) NOT NULL,
   "MGR"            integer,
   "HIREDATE"       date NOT NULL,
   "SAL"            integer NOT NULL,
   "COMM"           integer,
   "DEPTNO"         integer NOT NULL,
   
   PRIMARY KEY      ("EMPNO"),
   CONSTRAINT       "fk_MGR" FOREIGN KEY ("MGR") REFERENCES "emp" ("EMPNO")
      ON DELETE SET NULL
	  ON UPDATE CASCADE,
   CONSTRAINT       "fk_DEPTNO" FOREIGN KEY ("DEPTNO") REFERENCES "dept" ("DEPTNO")
      ON DELETE RESTRICT
	  ON UPDATE RESTRICT
);

INSERT INTO "emp" VALUES (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10);
INSERT INTO "emp" VALUES (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30);
INSERT INTO "emp" VALUES (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30);
INSERT INTO "emp" VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30);
INSERT INTO "emp" VALUES (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30);
INSERT INTO "emp" VALUES (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30);
INSERT INTO "emp" VALUES (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30);
INSERT INTO "emp" VALUES (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10);
INSERT INTO "emp" VALUES (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);
INSERT INTO "emp" VALUES (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20);
INSERT INTO "emp" VALUES (7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09', 3000, NULL, 20);
INSERT INTO "emp" VALUES (7876, 'ADAMS', 'CLERK', 7788, '1983-01-12', 1100, NULL, 20);
INSERT INTO "emp" VALUES (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20);
INSERT INTO "emp" VALUES (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20);


CREATE TABLE "proj" (
   "PROJID" integer NOT NULL,
   "EMPNO" integer NOT NULL,
   "STARTDATE" date NOT NULL,
   "ENDDATE" date NOT NULL,
   
   PRIMARY KEY ("PROJID"),
   CONSTRAINT "fk_PROJ" FOREIGN KEY ("EMPNO") REFERENCES "emp" ("EMPNO")
      ON DELETE RESTRICT
	  ON UPDATE CASCADE
);

INSERT INTO "proj" VALUES (1, 7782, '2005-06-16', '2005-06-18');
INSERT INTO "proj" VALUES (4, 7782, '2005-06-19', '2005-06-24');
INSERT INTO "proj" VALUES (7, 7782, '2005-06-22', '2005-06-25');
INSERT INTO "proj" VALUES (10, 7782, '2005-06-25', '2005-06-28');
INSERT INTO "proj" VALUES (13, 7782, '2005-06-28', '2005-07-02');
INSERT INTO "proj" VALUES (2, 7839, '2005-06-17', '2005-06-21');
INSERT INTO "proj" VALUES (8, 7839, '2005-06-23', '2005-06-25');
INSERT INTO "proj" VALUES (14, 7839, '2005-06-29', '2005-06-30');
INSERT INTO "proj" VALUES (11, 7839, '2005-06-26', '2005-06-27');
INSERT INTO "proj" VALUES (5, 7839, '2005-06-20', '2005-06-24');
INSERT INTO "proj" VALUES (3, 7934, '2005-06-18', '2005-06-22');
INSERT INTO "proj" VALUES (12, 7934, '2005-06-27', '2005-06-28');
INSERT INTO "proj" VALUES (15, 7934, '2005-06-30', '2005-07-03');
INSERT INTO "proj" VALUES (9, 7934, '2005-06-24', '2005-06-27');
INSERT INTO "proj" VALUES (6, 7934, '2005-06-21', '2005-06-23');


CREATE VIEW "Managers"
   AS SELECT m."ENAME" AS "Manager", e."ENAME" AS "Employee"
   FROM "emp" AS e LEFT JOIN "emp" AS m ON e."MGR" = m."EMPNO"
   ORDER BY m."ENAME", e."ENAME";

COMMENT ON VIEW "Managers" IS 'Pairs of manager-subordinate names';

CREATE MATERIALIZED VIEW "Materialized"
   AS SELECT m."ENAME" AS "Manager", e."ENAME" AS "Employee"
   FROM "emp" AS e LEFT JOIN "emp" AS m ON e."MGR" = m."EMPNO"
   ORDER BY m."ENAME", e."ENAME";
REFRESH MATERIALIZED VIEW "Materialized";


CREATE TABLE "datatypes" (
   "INTEGER_"        integer NOT NULL DEFAULT 213131,
   "TINY_INT"        tinyint,
   "SMALL_INT"       smallint DEFAULT 213,
   "BIG_INT"         bigint DEFAULT 44,
   "U_SMALLINT"      unsigned smallint,
   
   "BIT_"            bit,
   "VAR_BIT"         varbit(5),
   "LONG_VARBIT"     long varbit,
   "DECIMAL_"        decimal(12,3),
   "NUMERIC_"        numeric(7,2),
   "SMALL_MONEY"     "smallmoney" DEFAULT 22.33,
   "MONEY_"          "money",
   "FLOAT_"          float DEFAULT 333.55,
   "REAL_"           float,
   "DOUBLE_"         double DEFAULT 33.55,

   "CHAR_"           char(5) DEFAULT 'ABCDE',
   "NCHAR_"          nchar(5),
   "VAR_CHAR"        varchar(12) DEFAULT 'sdasda',
   "NVARCHAR_"       nvarchar(18),
   "LONG_NVARCHAR"   long nvarchar,
   "TEXT_"           "text",
   "NTEXT_"          "ntext",

   "DATE_"           date DEFAULT current date,
   "DATETIME_"       "datetime",
   "SMALL_DT"        "smalldatetime",
   "TIME_"           time,
   "TIME_STAMP"      timestamp,
   "TS_WTZ"          timestamp with time zone,
   "DT_OFFSET"       timestamp with time zone,

   "BINARY_"         binary(10),
   "VAR_BINARY"      varbinary(13),
   "LONG_BINARY"     long binary,
   "IMAGE_"          "image",

   "POINT_"          ST_Point,
   "POLYGON_"        ST_Polygon,
   "UID_"            uniqueidentifier,
   "XML_"            xml,
   
   PRIMARY KEY       ("INTEGER_") 
);

INSERT INTO "datatypes" ("BIG_INT", "BIT_", "CHAR_", "DATE_", "DECIMAL_", "DOUBLE_", "FLOAT_", "INTEGER_",
   "LONG_NVARCHAR", "MONEY_", "NCHAR_", "NUMERIC_", "NVARCHAR_", "REAL_", "SMALL_INT", "SMALL_MONEY", "U_SMALLINT", "XML_")
   VALUES (444, 1, 'wqewq', '2016-03-22 00:00', 44.2, 33.55, 333.549346923828125, 213131, 'asdasdasdas',
   33, 'asdas', 21321, 'ZXC', 21321, 213, 22.33, 2321, 'sdasda');


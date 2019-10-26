-- EmployeesQX - PostgreSQL.sql, for v8.4
-- Use pgAdmin or another PostgreSQL administrator.
-- Create a public EmployeesQX database, then run this script.

DROP TABLE IF EXISTS "datatypes";
DROP TYPE "mood";
DROP VIEW IF EXISTS "Managers";
DROP TABLE IF EXISTS "proj";
DROP TABLE IF EXISTS "emp";
DROP TABLE IF EXISTS "dept";

CREATE TABLE "dept" (
   "DEPTNO" integer NOT NULL,
   "DNAME" varchar(20) NOT NULL,
   "LOC" varchar(20) NOT NULL,
   
   PRIMARY KEY ("DEPTNO")
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
   "EMPNO" integer NOT NULL,
   "ENAME" varchar(20) NOT NULL,
   "JOB" varchar(20) NOT NULL,
   "MGR" integer,
   "HIREDATE" date NOT NULL,
   "SAL" integer NOT NULL,
   "COMM" integer,
   "DEPTNO" integer NOT NULL,
   
   PRIMARY KEY ("EMPNO"),
   CONSTRAINT "fk_MGR" FOREIGN KEY ("MGR") REFERENCES "emp" ("EMPNO")
      ON DELETE SET NULL
      ON UPDATE CASCADE,
   CONSTRAINT "fk_DEPTNO" FOREIGN KEY ("DEPTNO") REFERENCES "dept" ("DEPTNO")
      ON DELETE RESTRICT
	  ON UPDATE NO ACTION
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
      ON DELETE NO ACTION
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


CREATE VIEW "Managers" AS 
SELECT m."ENAME" AS "Manager", e."ENAME" AS "Employee"
FROM "emp" AS e LEFT JOIN "emp" AS m ON e."MGR" = m."EMPNO"
ORDER BY m."ENAME", e."ENAME";

COMMENT ON VIEW "Managers" IS 'Pairs of manager-subordinate names';


CREATE TYPE "mood" AS ENUM ('sad', 'ok', 'happy');
CREATE TABLE "datatypes" (

  "INTEGER_" integer NOT NULL,
  "INT_" int,
  "INT_4" int4,
  "SMALL_INT" smallint DEFAULT 23,
  "INT_2" int2,
  "BIG_INT" bigint,
  "INT_8" int8,
  "BIT_" bit(1),
  "BIT_VARYING" bit varying(5),
  "VAR_BIT" varbit(5),
  "BOOLEAN_" boolean,
  "BOOL_" bool,
  "MONEY_" money,
  "REAL_" real DEFAULT 45.55,
  "FLOAT_4" float4,
  "DOUBLE_PRECISION" double precision,
  "FLOAT_8" float8,
  "DECIMAL_" decimal(9,2),
  "NUMERIC_" numeric(7,2),
  "ENUM_" mood DEFAULT 'ok',
  
  "CHARACTER_" character(1),
  "CHAR_" char,
  "VARCHAR_" varchar(20),
  "CHARACTER_VARYING" character varying(20),
  "TEXT_" text,
  
  "DATE_" date,
  "TIME_" time,
  "TIME_WOTZ" time(6) without time zone,
  "TIME_WTZ" time(6) with time zone,
  "TIME_TZ" timetz,
  "TIMESTAMP_" timestamp,
  "TIMESTAMP_WTZ" timestamp(6) with time zone,
  "TIMESTAMP_TZ" timestamptz,
  "ABS_TIME" abstime,
  "REL_TIME" reltime,
  "INTERVAL_" interval(6),

  "BYTEA_" bytea,
  "TXID_SNAPSHOT_" txid_snapshot,
 
  "POINT_" point,
  "LINE_" line,
  "LSEG_" lseg,
  "BOX_" box,
  "PATH_" path,
  "POLYGON_" polygon,
  "CIRCLE_" circle,

  "TS_VECTOR" tsvector,
  "TS_QUERY" tsquery,

  "CIDR_" cidr,
  "INET_" inet,
  "MACADDR_" macaddr,

  "UUID_" uuid,
  "OID_" oid,
  "CID_" cid,
  "REG_PROC" regproc,
  "REG_PROCEDURE" regprocedure,
  "REG_OPER" regoper,
  "REG_OPERATOR" regoperator,
  "REG_CLASS" regclass,
  "REG_TYPE" regtype,
  
  "XML_" xml,
  
  "INT_ARRAY" int[],
  "CHAR_ARRAY" char(1)[],
  "VARCHAR_ARRAY" varchar(10)[],
  
  PRIMARY KEY ("INTEGER_")
);

INSERT INTO "datatypes" ("INTEGER_", "CHAR_", "BIG_INT", "CHARACTER_", "CHARACTER_VARYING",
  "DATE_", "DOUBLE_PRECISION", "NUMERIC_", "REAL_", "SMALL_INT", "INT_ARRAY")
   VALUES(55, 'A', 43543, 'c', 'asdas', '2016-01-02', 33.444, 3587, 22.01, 12, array[3,7,8,11]);


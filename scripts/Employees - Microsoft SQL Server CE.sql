-- EmployeesQX - Microsoft SQL Server CE.sql
-- Use LINQPad or another SQL Server CE console.
-- Create an EmployeesQX database, then run this script.
-- You can also connect to the ready-to-use EmployeesQX.sdf file.

-- DROP TABLE [datatypes];
-- DROP TABLE [proj];
-- DROP TABLE [emp];
-- DROP TABLE [dept];

CREATE TABLE [dept] (
   [DEPTNO] integer NOT NULL,
   [DNAME] nvarchar(20) NOT NULL,
   [LOC] nvarchar(20) NOT NULL,
   
   PRIMARY KEY ([DEPTNO])
);

INSERT INTO [dept] VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO [dept] VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO [dept] VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO [dept] VALUES (40, 'OPERATIONS', 'BOSTON');


CREATE TABLE [emp] (
   [EMPNO] integer NOT NULL,
   [ENAME] nvarchar(20) NOT NULL,
   [JOB] nvarchar(20) NOT NULL,
   [MGR] integer,
   [HIREDATE] datetime NOT NULL,
   [SAL] integer NOT NULL,
   [COMM] integer,
   [DEPTNO] integer NOT NULL,
   
   PRIMARY KEY ([EMPNO]),
   CONSTRAINT [fk_MGR] FOREIGN KEY ([MGR]) REFERENCES [emp] ([EMPNO])
      ON DELETE NO ACTION
	  ON UPDATE NO ACTION,
   CONSTRAINT [fk_DEPTNO] FOREIGN KEY ([DEPTNO]) REFERENCES [dept] ([DEPTNO])
      ON DELETE CASCADE
	  ON UPDATE CASCADE
);

INSERT INTO [emp] VALUES (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10);
INSERT INTO [emp] VALUES (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30);
INSERT INTO [emp] VALUES (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30);
INSERT INTO [emp] VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30);
INSERT INTO [emp] VALUES (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30);
INSERT INTO [emp] VALUES (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30);
INSERT INTO [emp] VALUES (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30);
INSERT INTO [emp] VALUES (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10);
INSERT INTO [emp] VALUES (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);
INSERT INTO [emp] VALUES (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20);
INSERT INTO [emp] VALUES (7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09', 3000, NULL, 20);
INSERT INTO [emp] VALUES (7876, 'ADAMS', 'CLERK', 7788, '1983-01-12', 1100, NULL, 20);
INSERT INTO [emp] VALUES (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20);
INSERT INTO [emp] VALUES (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20);


CREATE TABLE [proj] (
   [PROJID] integer NOT NULL,
   [EMPNO] integer NOT NULL,
   [STARTDATE] datetime NOT NULL,
   [ENDDATE] datetime NOT NULL,
   
   PRIMARY KEY ([PROJID]),
   CONSTRAINT [fk_PROJ] FOREIGN KEY ([EMPNO]) REFERENCES [emp] ([EMPNO])
      ON DELETE NO ACTION
	  ON UPDATE CASCADE
);

INSERT INTO [proj] VALUES (1, 7782, '2005-06-16', '2005-06-18');
INSERT INTO [proj] VALUES (4, 7782, '2005-06-19', '2005-06-24');
INSERT INTO [proj] VALUES (7, 7782, '2005-06-22', '2005-06-25');
INSERT INTO [proj] VALUES (10, 7782, '2005-06-25', '2005-06-28');
INSERT INTO [proj] VALUES (13, 7782, '2005-06-28', '2005-07-02');
INSERT INTO [proj] VALUES (2, 7839, '2005-06-17', '2005-06-21');
INSERT INTO [proj] VALUES (8, 7839, '2005-06-23', '2005-06-25');
INSERT INTO [proj] VALUES (14, 7839, '2005-06-29', '2005-06-30');
INSERT INTO [proj] VALUES (11, 7839, '2005-06-26', '2005-06-27');
INSERT INTO [proj] VALUES (5, 7839, '2005-06-20', '2005-06-24');
INSERT INTO [proj] VALUES (3, 7934, '2005-06-18', '2005-06-22');
INSERT INTO [proj] VALUES (12, 7934, '2005-06-27', '2005-06-28');
INSERT INTO [proj] VALUES (15, 7934, '2005-06-30', '2005-07-03');
INSERT INTO [proj] VALUES (9, 7934, '2005-06-24', '2005-06-27');
INSERT INTO [proj] VALUES (6, 7934, '2005-06-21', '2005-06-23');


CREATE TABLE [datatypes] (

   [INTEGER_] integer NOT NULL,

   [TINY_INT] tinyint DEFAULT 2,
   [SMALL_INT] smallint DEFAULT 3,
   [BIG_INT] bigint DEFAULT 44,
   [BIT_] bit,
   
   [FLOAT_] float DEFAULT 44.55,
   [REAL_] real DEFAULT 55.66,
   [MONEY_] money DEFAULT 66.77,
   [NUMERIC_] numeric(8, 2) DEFAULT 12.34,
   
   [NCHAR_] nchar(5) DEFAULT 'abc',
   [NCHAR2_] national character(5),
   [NVARCHAR_] nvarchar(20) DEFAULT 'def',
   [NVARCHAR2_] national character varying(5),
   [NTEXT_] ntext,
   
   [DATETIME_] datetime,

   [BINARY_] binary(20),
   [VARBINARY_] varbinary(33),
   [IMAGE_] image,
   [UID_] uniqueidentifier,

   PRIMARY KEY ([INTEGER_])
);

INSERT INTO [datatypes] ([INTEGER_], [NCHAR_], [NCHAR2_], [NVARCHAR_], [NTEXT_],
   [BIT_], [NUMERIC_], [TINY_INT], [SMALL_INT], [BIG_INT], [FLOAT_], [REAL_], [MONEY_], [DATETIME_])
   VALUES (225, 'abcde', 'fgh', '2233', 'asdas',
   0, 12.34, 23, 223, 23456, 33.78, 678.44, 1234.55, '2016-01-02 12:22:33');


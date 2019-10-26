-- EmployeesQX - Microsoft SQL Azure.sql
-- Use SQL Server Management Studio or another Azure/SQL Server administrator.
-- Create an EmployeesQX database, then run this script.

USE EmployeesQX
GO

DROP TABLE IF EXISTS [datatypes];
DROP VIEW IF EXISTS [Managers];
DROP VIEW  IF EXISTS [Materialized];
DROP TABLE IF EXISTS [proj];
DROP TABLE IF EXISTS [emp];
DROP TABLE IF EXISTS [dept];
GO

CREATE TABLE [dept] (
   [DEPTNO] integer NOT NULL,
   [DNAME] varchar(20) NOT NULL,
   [LOC] varchar(20) NOT NULL,
   
   PRIMARY KEY ([DEPTNO])
);
GO

INSERT INTO [dept] VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO [dept] VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO [dept] VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO [dept] VALUES (40, 'OPERATIONS', 'BOSTON');
GO


CREATE TABLE [emp] (
   [EMPNO] integer NOT NULL,
   [ENAME] varchar(20) NOT NULL,
   [JOB] varchar(20) NOT NULL,
   [MGR] integer,
   [HIREDATE] date NOT NULL,
   [SAL] integer NOT NULL,
   [COMM] integer,
   [DEPTNO] integer NOT NULL,
   
   PRIMARY KEY ([EMPNO]),
   CONSTRAINT [fk_MGR] FOREIGN KEY ([MGR]) REFERENCES [emp] ([EMPNO])
      ON DELETE NO ACTION
	  ON UPDATE NO ACTION,
   CONSTRAINT [fk_DEPTNO] FOREIGN KEY ([DEPTNO]) REFERENCES [dept] ([DEPTNO])
      ON DELETE CASCADE
	  ON UPDATE NO ACTION
);
GO

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
GO


CREATE TABLE [proj] (
   [PROJID] integer NOT NULL,
   [EMPNO] integer NOT NULL,
   [STARTDATE] date NOT NULL,
   [ENDDATE] date NOT NULL,
   
   PRIMARY KEY ([PROJID]),
   CONSTRAINT [fk_PROJ] FOREIGN KEY ([EMPNO]) REFERENCES [emp] ([EMPNO])
      ON DELETE NO ACTION
	  ON UPDATE CASCADE
);
GO

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
GO


CREATE VIEW [Managers] AS 
SELECT m.[ENAME] AS [Manager], e.[ENAME] AS [Employee]
FROM [dbo].[emp] AS e LEFT JOIN [dbo].[emp] AS m ON e.[MGR] = m.[EMPNO];
GO

CREATE VIEW [Materialized] WITH SCHEMABINDING
   AS SELECT m.[ENAME] AS [Manager]
   FROM [dbo].[emp] AS m;
GO
CREATE UNIQUE CLUSTERED INDEX [IDX_Materialized]
   ON [dbo].[Materialized] ([Manager]);
GO


CREATE TABLE [datatypes] (
	
   [INT_] int NOT NULL DEFAULT 2312,
	
   [TINY_INT] tinyint DEFAULT 3,
   [SMALL_INT] smallint DEFAULT 232,
   [BIG_INT] bigint,
   [BIT_] bit DEFAULT 0,
   [DECIMAL_] decimal(18, 0),
   [NUMERIC_] numeric(18, 2) DEFAULT 234234,
   [FLOAT_] float DEFAULT 444.44,
   [REAL_] real,
   [SMALL_MONEY] smallmoney DEFAULT 11.23,
   [MONEY_] money DEFAULT 22.33,

   [CHAR_] char(10) DEFAULT 'D',
   [NCHAR_] nchar(10) DEFAULT N'D',
   [VAR_CHAR] varchar(50) DEFAULT 'zxcxcvxvcxvxv',
   [VAR_CHAR_MAX] varchar(max),
   [NVARCHAR_] nvarchar(50) DEFAULT N'ASDASD',
   [NVARCHAR_MAX] nvarchar(max),
   [TEXT_] text,
   [NTEXT_] ntext,
	
   [DATE_] date,
   [SMALL_DT] smalldatetime,
   [TIME_] time(7),
   [TIMESTAMP_] timestamp,
   [DATETIME_] datetime,
   [DATETIME2_] datetime2(7) DEFAULT '2012-03-04',
   [DATETIME_OFF] datetimeoffset(7),
	
   [BINARY_] binary(50),
   [VARBIN] varbinary(50),
   [VARBIN_MAX] varbinary(max),
   [IMAGE_] image,
	
   [GEOGRAPHY_] geography,
   [GEOMETRY_] geometry,
   [HIER_ID] hierarchyid,
   [SQL_VAR] sql_variant,
   [UID_] uniqueidentifier,
   [XML_] xml,
	
   PRIMARY KEY ([INT_]) 
);
GO

INSERT INTO [datatypes] ([BIG_INT], [BIT_], [CHAR_], [DATE_], [DECIMAL_], [FLOAT_], [INT_], 
   [MONEY_], [NCHAR_], [REAL_], [SMALL_INT], [SMALL_MONEY], [TINY_INT], [VAR_CHAR], [VAR_CHAR_MAX])
   VALUES (234, 0, 'abcdefghij', '2012-04-04', 12.34, 44.55, 12345,
   44.56, N'1234567890', 9999, 2, 22.50, 2, 'var char', 'var char max');
GO


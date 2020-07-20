----------------- Final ------------------------

-------------------------------------------
------------- PREPARE DATA ----------------
-------------------------------------------

-- 1)Create Table
-- 1.1) Table "Task" from Import CSV
-- 1.2) Table for store FaultCode by Month
CREATE TABLE IF NOT EXISTS 'FaultCodesCountbyMonth' (
	'Building' TEXT,
	'FaultCode' TEXT,
	'QTY' NUMERIC,
	'Month' NUMERIC,
	'Year' NUMERIC
);
-- 1.3) Table for store Order Status by Month
CREATE TABLE IF NOT EXISTS 'OrderStatusCountByMonth' (
	'Building' TEXT,
	'Status' TEXT,
	'QTY' NUMERIC,
	'Month' NUMERIC,
	'Year' NUMERIC
);

-- 1.4) Building Data TABLE
CREATE TABLE IF NOT EXISTS `BuildingData` (
	`NO`	INTEGER,
	`BUILDING`	TEXT,
	`Surveyor`	TEXT,
	`MRI_ID`	TEXT
	'IsActive'	TEXT
	'BldgShortName' TEXT,
	'BldgType' TEXT
	'IsBldgOPActive' TEXT
);

-- 1.5) Create Table Order Status
-- 1.5.1) Create Table
CREATE TABLE IF NOT EXISTS `OrderStatus` (
	`Status`	TEXT
);
-- 1.5.2) Insert Standard STATUS into OrderStatus Table
DELETE FROM Orderstatus
INSERT INTO OrderStatus (status)
VALUES
	  ("ACTIVE")
	, ("COMPLETE");

-- 1.6) Create Table Month pf year
CREATE TABLE IF NOT EXISTS "MonthOfYear"(
	"MonthID" Integer,
	"MonthName" Text,
	"MonthNameTH" Text,
	"MonthFullName" Text,
CONSTRAINT "unique_MonthID" UNIQUE ( "MonthID" ) );
-- Fill Data
DELETE FROM MonthOfYear;
INSERT INTO MonthOfYear (MonthID, MonthName)
VALUES
	  (1 , "Jan" , "มกราคม" , "January")
	, (2 , "Feb" , "กุมภาพันธฺ" , "February")
	, (3 , "Mar" , "มีนาคม" , "March")
	, (4 , "Apr" , "เมษายน" , "April")
	, (5 , "May" , "พฤษภาคม" , "May")
	, (6 , "Jun" , "มิถุนายน" , "June")
	, (7 , "Jul" , "กรกฎาคม" , "July")
	, (8 , "Aug" , "สิงหาคม" , "August")
	, (9 , "Sep" , "กันยายน" , "September")
	, (10 , "Oct" , "ตุลาคม" , "October")
	, (11 , "Nov" , "พฤศจิกายน" , "November")
	, (12 , "Dec" , "ธันวาคม" , "December");

-- 1.7) CREATE TABLE "refStatusDescription" -------------------------
CREATE TABLE IF NOT EXISTS "refStatusDescription"(
	"DesID" Integer,
	"Description" Text,
CONSTRAINT "unique_DesID" UNIQUE ( "DesID" ) );
-- Fill in DATA
DELETE FROM refStatusDescription;
INSERT INTO refStatusDescription
VALUES
	  (1 , 'Active Order' )
	, (2 , 'Completed Order')
	, (3 , 'Total Order');


-- 1.8) CREATE TABLE "tempEvoMonthlyReport"
CREATE TABLE IF NOT EXISTS "tempEvoMonthlyReport"(
	"Building" Text,
	"BldgShortName" Text,
	"BldgType" Text,
	"QtyComArea" Integer,
	"Tenant" Integer,
	"Common" Integer,
	"TopTenant" Text,
	"TopCommon" Text,
	"TopCommonQty3rdRank" Text,
	"TopTenantQty3rdRank", Text);

-- 1.9 CREATE TABLE "refDayOfMonth"
CREATE TABLE IF NOT EXISTS "refDayOfMonth"(
	"Date" Integer,
	"Type" Text );

DELETE FROM refDayOfMonth;
INSERT INTO refDayOfMonth
VALUES
	  (1, '30D') , (2, '30D') , (3, '30D') , (4, '30D') , (5, '30D')
	, (6, '30D') , (7, '30D') , (8, '30D') , (9, '30D') , (10, '30D')
	, (11, '30D') , (12, '30D') , (13, '30D') , (14, '30D') , (15, '30D')
	, (16, '30D') , (17, '30D') , (18, '30D') , (19, '30D') , (20, '30D')
	, (21, '30D') , (22, '30D') , (23, '30D') , (24, '30D') , (25, '30D')
	, (26, '30D') , (27, '30D') , (28, '30D') , (29, '30D') , (30, '30D')
	, (31, '31D');




-------------------------------------------------------------------
--------------------- CORRECT DATA --------------------------------
-------------------------------------------------------------------

-- 1) Modify Data in database before using it
-- 1.1) Change Building Name "AIA Sathorn Tower" to "AIA SATHORN TOWER"
UPDATE Task
SET
	building = replace(building,"AIA Sathorn Tower","AIA SATHORN TOWER")
WHERE
	building = "AIA Sathorn Tower";

-- 1.2) Chenage Status from "HISTORY" to "COMPLETE"
UPDATE Task
SET status = replace(status,"HISTORY","COMPLETE");

-- 1.3) Delete data of "Demo Building"
DELETE
FROM
	Task
WHERE
	building like "%demo%";

-- 2) Modify Column Name from Evo V5 to Evo V4
ALTER TABLE Task
	RENAME COLUMN TaskType to Type;
ALTER TABLE Task
	RENAME COLUMN TaskReportedDate to ReportedDate;



-------------------------------------------------------------------
--------------------- FILL IN THE TABLE ---------------------------
-------------------------------------------------------------------
-- 1) Count Order

-- 1.1) Count and Catagory Last Month Order to Fault Code and put the result into the Table
-- Table Name : FaultCodesCountbyMonth
-- Create 3/09/2018 by Khemmachat Mangkornsaksit
-- Modified 3/09/2018 by Khemmachat Mangkornsaksit
-- BUG :
-----------------------------------------------------------------------------
--| Building           | FaultCode                     | QTY | Month | Year |
-----------------------------------------------------------------------------
--| AIA SATHORN TOWER	 | Air Condition - ระบบปรับอากาศ  |	 4	| 8			| 2018 |
--| AIA SATHORN TOWER	 | Complain - คำร้องทั่วไป					|  2	| 8			|	2018 |
--| AIA SATHORN TOWER	 | Electrical - ระบบไฟฟ้า					|  51	| 8			|	2018 |
-----------------------------------------------------------------------------
DELETE FROM FaultCodesCountbyMonth;
INSERT INTO FaultCodesCountbyMonth
	SELECT DISTINCT Building
		,	"FaultCodes", count(*) AS CountCode
		,	strftime('%m',DATE('now','start of month','-1 month')) AS month
		, strftime('%Y',DATE('now','-1 month')) AS Year
	FROM Task
	WHERE
		building <> "Demo Building"
		AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
			BETWEEN
				DATE('now','start of month','-1 month') AND DATE('now','start of month', '-1 day')
	GROUP BY building, "FaultCodes";

-- 3.2) Count Number of Active and Complete Order of each month and put the result into the Table
-- Table Name : OrderStatusCountByMonth
-- Create 2/09/2018 by Khemmachat Mangkornsaksit
-- Modified 2/09/2018 by Khemmachat Mangkornsaksit
-- BUG :
--------------------------------------------------------
--| Building           | Status   | QTY | Month | Year |
--------------------------------------------------------
--| AIA SATHORN TOWER	 | COMPLETE |	 84	|	 	8		| 2018 |
--| AIA SATHORN TOWER	 | COMPLETE	|  75	| 	8		|	2018 |
--| AIA SATHORN TOWER	 | ACTIVE		|  0	|  	8		|	2018 |
--------------------------------------------------------
DELETE FROM OrderStatusCountByMonth;
INSERT INTO OrderStatusCountByMonth
	SELECT
			building
		,	replace(status,"HISTORY","COMPLETE") AS Status
		,	count(status) AS CountStatus
		,	strftime('%m',DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2)) ) AS month
		,	strftime('%Y',DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2)) ) AS Year
	 FROM Task
	 WHERE
	 	building <> "Demo Building"
		AND year = strftime('%Y','now')
	 GROUP BY building, status, month
	 ORDER BY building, year, month, status;









-------------------------------------------------------------------
--------------------- PREPARE DATA FOR REPORTING ------------------
-------------------------------------------------------------------

----------------------- START OF Fill in tempActiveBuilding2 ------------------
-- 1) Count Active and Complete Order of Last Month
-- Table Name : tempActiveBuilding2
-- Datasource : OrderStatusCountByMonth
-- Create 10/09/2018 by Khemmachat Mangkornsaksit
-- Modified 14/09/2018 by Khemmachat Mangkornsaksit
-- BUG : Can't Distinctguish between Building OP and Engineering PPM
--------------------------------------------------
--|    BUILDING	   		|  Status   | Jan | Feb |
--------------------------------------------------
--| AIA SATHORN TOWER	|  ACTIVE 	|  0  |  0  |
--| AIA SATHORN TOWER	| COMPLETE 	| 131 |  79 |
--------------------------------------------------
-- 1.1) Create Temporary Table
--CREATE TEMPORARY TABLE IF NOT EXISTS tempActiveBuilding2
CREATE TABLE IF NOT EXISTS tempActiveBuilding2
	(
		'Building' TEXT
	, 'BldgShortName' TEXT
	, 'Status' TEXT
	, JanQty INTEGER DEFAULT 0
	, FebQty INTEGER DEFAULT 0
	, MarQty INTEGER DEFAULT 0
	, AprQty INTEGER DEFAULT 0
	, MayQty INTEGER DEFAULT 0
	, JunQty INTEGER DEFAULT 0
	, JulQty INTEGER DEFAULT 0
	, AugQty INTEGER DEFAULT 0
	, SepQty INTEGER DEFAULT 0
	, OctQty INTEGER DEFAULT 0
	, NovQty INTEGER DEFAULT 0
	, DecQty INTEGER DEFAULT 0
	, Total INTEGER DEFAULT 0
	);
-- 1.2) Create Temporary Table
DELETE FROM tempActiveBuilding2;
INSERT INTO tempActiveBuilding2
	SELECT
  	  Building
		, BldgShortName
    , Status
    , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	FROM
 		BuildingData
  JOIN OrderStatus
  WHERE isactive = "Active"
  ORDER BY building;

-- 1.3) Assign QTY Value to temporary TABLE
UPDATE tempActiveBuilding2
SET JanQty =
		(
		select
		-- case when countstatus is null then 0 else countstatus end
		-- case when QTY IS NULL then 0 else QTY end
		CASE WHEN strftime('%m','now') = '01' then 0 else QTY end
		from OrderStatusCountByMonth
		where building = tempActiveBuilding2.BUILDING
			and status = tempActiveBuilding2.Status
			AND OrderStatusCountByMonth.Month = 1
			-- AND OrderStatusCountByMonth.Month = cast(strftime('%m','now','-1 month') as integer)
		  AND OrderStatusCountByMonth.Year = strftime('%Y','now')
		 )
	, FebQty =
    (
		select
		-- case when countstatus is null then 0 else countstatus end
		-- case when QTY IS NULL then 0 else QTY end
		CASE WHEN strftime('%m','now') = '02' then 0 else QTY end
		from OrderStatusCountByMonth
		where building = tempActiveBuilding2.BUILDING
			and status = tempActiveBuilding2.Status
			AND OrderStatusCountByMonth.Month = 2
			-- AND OrderStatusCountByMonth.Month = cast(strftime('%m','now','-1 month') as integer)
			AND OrderStatusCountByMonth.Year = strftime('%Y','now')
    )
	, MarQty =
    (
		select
		-- case when countstatus is null then 0 else countstatus end
		-- case when QTY IS NULL then 0 else QTY end
		CASE WHEN strftime('%m','now') = '03' then 0 else QTY end
		from OrderStatusCountByMonth
		where building = tempActiveBuilding2.BUILDING
			and status = tempActiveBuilding2.Status
			AND OrderStatusCountByMonth.Month = 3
			-- AND OrderStatusCountByMonth.Month = cast(strftime('%m','now','-1 month') as integer)
			AND OrderStatusCountByMonth.Year = strftime('%Y','now')
    )
	, AprQty =
    (
		select
		-- case when countstatus is null then 0 else countstatus end
		-- case when QTY IS NULL then 0 else QTY end
		CASE WHEN strftime('%m','now') = '04' then 0 else QTY end
		from OrderStatusCountByMonth
		where building = tempActiveBuilding2.BUILDING
			and status = tempActiveBuilding2.Status
			AND OrderStatusCountByMonth.Month = 4
			-- AND OrderStatusCountByMonth.Month = cast(strftime('%m','now','-1 month') as integer)
			AND OrderStatusCountByMonth.Year = strftime('%Y','now')
    )
	, MayQty =
    (
		select
		-- case when countstatus is null then 0 else countstatus end
		-- case when QTY IS NULL then 0 else QTY end
		CASE WHEN strftime('%m','now') = '05' then 0 else QTY end
		from OrderStatusCountByMonth
		where building = tempActiveBuilding2.BUILDING
			and status = tempActiveBuilding2.Status
			AND OrderStatusCountByMonth.Month = 5
			-- AND OrderStatusCountByMonth.Month = cast(strftime('%m','now','-1 month') as integer)
			AND OrderStatusCountByMonth.Year = strftime('%Y','now')
    )
	, JunQty =
    (
		select
		-- case when countstatus is null then 0 else countstatus end
		-- case when QTY IS NULL then 0 else QTY end
		CASE WHEN strftime('%m','now') = '06' then 0 else QTY end
		from OrderStatusCountByMonth
		where building = tempActiveBuilding2.BUILDING
			and status = tempActiveBuilding2.Status
			AND OrderStatusCountByMonth.Month = 6
			-- AND OrderStatusCountByMonth.Month = cast(strftime('%m','now','-1 month') as integer)
			AND OrderStatusCountByMonth.Year = strftime('%Y','now')
    )
	, JulQty =
    (
		select
		-- case when countstatus is null then 0 else countstatus end
		-- case when QTY IS NULL then 0 else QTY end
		CASE WHEN strftime('%m','now') = '07' then 0 else QTY end
		from OrderStatusCountByMonth
		where building = tempActiveBuilding2.BUILDING
			and status = tempActiveBuilding2.Status
			AND OrderStatusCountByMonth.Month = 7
			-- AND OrderStatusCountByMonth.Month = cast(strftime('%m','now','-1 month') as integer)
			AND OrderStatusCountByMonth.Year = strftime('%Y','now')
    )
	, AugQty =
    (
		select
		-- case when countstatus is null then 0 else countstatus end
		-- case when QTY IS NULL then 0 else QTY end
		CASE WHEN strftime('%m','now') = '08' then 0 else QTY end
		from OrderStatusCountByMonth
		where building = tempActiveBuilding2.BUILDING
			and status = tempActiveBuilding2.Status
			AND OrderStatusCountByMonth.Month = 8
			-- AND OrderStatusCountByMonth.Month = cast(strftime('%m','now','-1 month') as integer)
			AND OrderStatusCountByMonth.Year = strftime('%Y','now')
    )
	, SepQty =
    (
		select
		-- case when countstatus is null then 0 else countstatus end
		-- case when QTY IS NULL then 0 else QTY end
		CASE WHEN strftime('%m','now') = '09' then 0 else QTY end
		from OrderStatusCountByMonth
		where building = tempActiveBuilding2.BUILDING
			and status = tempActiveBuilding2.Status
			AND OrderStatusCountByMonth.Month = 9
			-- AND OrderStatusCountByMonth.Month = cast(strftime('%m','now','-1 month') as integer)
			AND OrderStatusCountByMonth.Year = strftime('%Y','now')
    )
	, OctQty =
    (
		select
		-- case when countstatus is null then 0 else countstatus end
		-- case when QTY IS NULL then 0 else QTY end
		CASE WHEN strftime('%m','now') = '10' then 0 else QTY end
		from OrderStatusCountByMonth
		where building = tempActiveBuilding2.BUILDING
			and status = tempActiveBuilding2.Status
			AND OrderStatusCountByMonth.Month = 10
			-- AND OrderStatusCountByMonth.Month = cast(strftime('%m','now','-1 month') as integer)
			AND OrderStatusCountByMonth.Year = strftime('%Y','now')
    )
	, NovQty =
    (
		select
		-- case when countstatus is null then 0 else countstatus end
		-- case when QTY IS NULL then 0 else QTY end
		CASE WHEN strftime('%m','now') = '11' then 0 else QTY end
		from OrderStatusCountByMonth
		where building = tempActiveBuilding2.BUILDING
			and status = tempActiveBuilding2.Status
			AND OrderStatusCountByMonth.Month = 11
			-- AND OrderStatusCountByMonth.Month = cast(strftime('%m','now','-1 month') as integer)
			AND OrderStatusCountByMonth.Year = strftime('%Y','now')
    )
	, DecQty =
    (
		select
		-- case when countstatus is null then 0 else countstatus end
		-- case when QTY IS NULL then 0 else QTY end
		CASE WHEN strftime('%m','now') = '12' then 0 else QTY end
		from OrderStatusCountByMonth
		where building = tempActiveBuilding2.BUILDING
			and status = tempActiveBuilding2.Status
			AND OrderStatusCountByMonth.Month = 12
			-- AND OrderStatusCountByMonth.Month = cast(strftime('%m','now','-1 month') as integer)
		  AND OrderStatusCountByMonth.Year = strftime('%Y','now')
    )
		, Total =
	 	(
 		SELECT
      sum(qty)
 		FROM OrderStatusCountByMonth
 		WHERE building = tempActiveBuilding2.BUILDING
 			AND status = tempActiveBuilding2.Status
 			AND OrderStatusCountByMonth.Year = strftime('%Y','now')
			AND OrderStatusCountByMonth.month <> strftime('%m', 'now')
	 	);

-- 1.4) Assign 0 to record that Qty is NULL
UPDATE tempActiveBuilding2 SET JanQty = 0 WHERE JanQty IS NULL;
UPDATE tempActiveBuilding2 SET FebQty = 0 WHERE FebQty IS NULL;
UPDATE tempActiveBuilding2 SET MarQty = 0 WHERE MarQty IS NULL;
UPDATE tempActiveBuilding2 SET AprQty = 0 WHERE AprQty IS NULL;
UPDATE tempActiveBuilding2 SET MayQty = 0 WHERE MayQty IS NULL;
UPDATE tempActiveBuilding2 SET JunQty = 0 WHERE JunQty IS NULL;
UPDATE tempActiveBuilding2 SET JulQty = 0 WHERE JulQty IS NULL;
UPDATE tempActiveBuilding2 SET AugQty = 0 WHERE AugQty IS NULL;
UPDATE tempActiveBuilding2 SET SepQty = 0 WHERE SepQty IS NULL;
UPDATE tempActiveBuilding2 SET OctQty = 0 WHERE OctQty IS NULL;
UPDATE tempActiveBuilding2 SET NovQty = 0 WHERE NovQty IS NULL;
UPDATE tempActiveBuilding2 SET DecQty = 0 WHERE DecQty IS NULL;
UPDATE tempActiveBuilding2 SET Total = 0 WHERE Total IS NULL;

----------------------- END OF Fill In tempActiveBuilding2 ------------------


----------------------- START OF temLastMComTen ------------------
-- 3) Count Active and Complete Order of Last Month
-- Table Name : tempLMonthComTen
-- Create 10/09/2018 by Khemmachat Mangkornsaksit
-- Modified 10/09/2018 by Khemmachat Mangkornsaksit
-- BUG :
------------------------------------------------------------------------
--|    BUILDING	   		|  Description    | Tenant | Common | TotalOrder |
------------------------------------------------------------------------
--| AIA SATHORN TOWER	| Active Order    |     3  |     2  |       5    |
--| AIA SATHORN TOWER	| Completed Order |     31 |    10  |      41    |
--| AIA SATHORN TOWER	| Total Order     |     34 |    12  |      46    |
------------------------------------------------------------------------

-- 3.1) Create Table
CREATE TABLE IF NOT EXISTS "tempLMonthComTen"(
	"Building" Text,
	"Description" Text,
	"Tenant" Integer,
	"Common" Integer,
	"TotalOrder" Integer );

-- 3.2) Count Number of TotalOrder
DELETE FROM tempLMonthComTen;
INSERT INTO tempLMonthComTen

SELECT
	  building
	, "Total Order" as Description
	,  0 AS Tenant
	, (
		SELECT
			count(Taskid)
		FROM
			Task T2
		WHERE T2.building <> "Demo Building"
			AND date(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
				BETWEEN DATE('now','start of month','-1 month') AND date('now','start of month', '-1 day')
			AND (T2.TenantReference LIKE "%common%" OR T2.TenantReference LIKE "%Car Park%" OR T2.TenantReference LIKE "%FL.%")
			AND T1.building = T2.building
	   ) Common
	, count(taskid) AS TotalOrder
FROM task T1
WHERE building <> "Demo Building"
		AND date(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
			BETWEEN DATE('now','start of month','-1 month') AND date('now','start of month', '-1 day')
GROUP BY building

UNION

-- 3.3) Count Number of Completed Order
SELECT
	  building
	, "Completed Order" as Description
	, 0 AS Tenant
	, (
		SELECT
			count(Taskid)
		FROM
			Task T4
		WHERE T4.building <> "Demo Building"
			AND date(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
				BETWEEN DATE('now','start of month','-1 month') AND date('now','start of month', '-1 day')
			AND (T4.TenantReference LIKE "%common%" OR T4.TenantReference LIKE "%Car Park%" OR T4.TenantReference LIKE "%FL.%")
			AND T3.building = T4.building
			AND T4.status = "COMPLETE"
	   ) Common
	, count(taskid) as TotalOrder
FROM
	Task T3
WHERE building <> "Demo Building"
		AND date(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
			BETWEEN DATE('now','start of month','-1 month') AND date('now','start of month', '-1 day')
		AND status = "COMPLETE"
GROUP BY building

UNION

-- 3.4) Count Number of Active Order
SELECT
	  building
	, "Active Order" as Description
	, 0 AS Tenant
	, (
		SELECT
			count(Taskid)
		FROM
			Task T6
		WHERE T6.building <> "Demo Building"
			AND date(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
				BETWEEN DATE('now','start of month','-1 month') AND date('now','start of month', '-1 day')
			AND (T6.TenantReference LIKE "%common%" OR T6.TenantReference LIKE "%Car Park%" OR T6.TenantReference LIKE "%FL.%")
			AND T5.building = T6.building
			AND T6.status = "ACTIVE"
	   ) Common
	, count(taskid) as TotalOrder
FROM
	Task T5
WHERE building <> "Demo Building"
		AND date(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
			BETWEEN DATE('now','start of month','-1 month') AND date('now','start of month', '-1 day')
		AND status = "ACTIVE"
GROUP BY building
ORDER BY building;

-- 3.5) Calculate Tenant Order = Total - Common and put it back to Tenant Field
UPDATE tempLMonthComTen
SET Tenant =
	(
	select
		totalorder - common
	);

-- 3.6) Insert the missing data of
--      Number of Active and Complete Order
--      according to Area Type of Last month
-- Created 12/09/2018 by Khemmachat Mangkornsaksit
-- Modifed 12/09/2018 by Khemmachat Mangkornsaksit
-- BUG : -
INSERT INTO tempLMonthComTen
SELECT
      building
    , description
    , 0 as Tenant
    , 0 As Common
    , 0 as TotalOrder
FROM
    (
    SELECT
        *
    FROM
        (
        select distinct
                Building
              , refStatusDescription.Description
        from tempLMonthComTen
        JOIN refStatusDescription
        ORDER BY building
        ) as lastMonthOrder
    WHERE not exists (select building, description from tempLMonthComTen where lastmonthorder.building = templmonthcomten.building
       and lastmonthorder.description = tempLMonthComTen.Description)
    )
ORDER BY building, description;

----------------------- END OF tempLMonthComTen ------------------


------------------- START FILL IN tempTopTenant -----------------------
-- 2) Count and Sort Last Month Order according by Tenant
-- Table Name : tempTopTenant
-- Created 3/09/2018 by Khemmachat Mangkornsaksit
-- Modified 28/02/2019 by Khemmachat Mangkornsaksit
-- BUG : -
---------------------------------------------------------------
--| BUILDING					| TenantReference 		| QTY | RankNo |
---------------------------------------------------------------
--| AIA SATHORN TOWER	|ASICS (Thailand)    	|	 3	|    1   |
--| AIA SATHORN TOWER	|DeloitteAdvisory2501	|	 1	|    2   |
--| AIA SATHORN TOWER	| DeloitteAudits-2302	|	 1	|    2   |
---------------------------------------------------------------

-- 1.3) Table for store Order Status by Month
CREATE TABLE IF NOT EXISTS 'tempTopTenant' (
	  'Building' TEXT
	, 'AreaType' TEXT
	, 'TenantReference' TEXT
	, 'QTY' NUMERIC
	, 'RankNo' NUMERIC
--	, 'RowNumber' NUMERIC
);

-- 1.4) Delete Existing Data
DELETE FROM temptoptenant;
INSERT INTO temptoptenant

-- 1.5) Add New Data with Ranking Number
SELECT
	  building
	, AreaType
	, TenantReference
	, COUNT(TenantReference) AS QTY
	, RANK () OVER (PARTITION BY Building, AreaType ORDER BY COUNT(TenantReference) DESC) AS RankNo
FROM
	(
		SELECT
				Building
			, 'Tenant' AS AreaType
			,	TenantReference
			, taskid
			, DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2)) as ReportDate
		FROM Task
		WHERE
			building <> "Demo Building"
			AND TenantReference NOT LIKE "%Common Area%"
			AND TenantReference NOT LIKE "%Car Park%"
			AND TenantReference NOT LIKE "%FL.%"
			AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
				BETWEEN DATE('now','start of month','-1 month') AND DATE('now','start of month', '-1 day')

		UNION

		SELECT
				Building
			, 'Common' as AreaType
			,	TenantReference
			, taskid
			, DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2)) as ReportDate
		FROM Task
		WHERE
			building <> "Demo Building"
			AND
			(
						TenantReference LIKE "%Common Area%"
						OR TenantReference LIKE "%Car Park%"
						OR TenantReference LIKE "%FL.%"
			)
			AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
				BETWEEN DATE('now','start of month','-1 month') AND DATE('now','start of month', '-1 day')
	)
GROUP BY building, areatype, tenantreference
ORDER BY building, areatype, QTY DESC

-- 1.6) Filter data Only Top Ranking


-------------------- END OF tempTopTenant ---------------------------


-- Create Data for Report
-- 3.3) Create tempEvoMonthlyReport
----------- START Table : tempEvoMonthlyReport ---------------
-- ?)
-- Table Name : tempEvoMonthlyReport
-- Report : Report_EvoMonthlyReport
-- Created 15/09/2018 by Khemmachat Mangkornsaksit
-- Modified 16/09/2018 by Khemmachat Mangkornsaksit
-- BUG : -
DELETE FROM tempEvoMonthlyReport;
INSERT INTO tempEvoMonthlyReport
select
	  building
	, bldgshortname
	, bldgtype
	, (
			select
				count(Qty)
			from tempTopTenant T2
			where T2.areatype = "Common"
				and T1.building = T2.building
		) as QtyComArea
	, (
			select
				count(description) as Qty
			from task T3
			where
				building <> "Demo Building"
				and T1.building = T3.building
				AND date(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
					BETWEEN DATE('now','start of month','-1 month') AND date('now','start of month', '-1 day')
					AND (TenantReference Not LIKE "%common%" AND TenantReference not LIKE "%Car Park%" AND TenantReference not LIKE "%FL.%" 					OR Tenantreference is null)
		) as Tenant
	, (
			select
				count(description) as Qty
			from task T4
			where
				building <> "Demo Building"
				and T1.building = T4.building
				AND date(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
					BETWEEN DATE('now','start of month','-1 month') AND date('now','start of month', '-1 day')
					AND (TenantReference LIKE "%common%" OR TenantReference LIKE "%Car Park%" OR TenantReference LIKE "%FL.%")
		) as Common
	,	(
		SELECT
			tenantreference
		FROM temptoptenant T5
		WHERE areatype = "Tenant"
			AND T1.building = T5.building
--			AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
--				BETWEEN DATE('now','start of month','-1 month') AND DATE('now','start of month', '-1 day')
		GROUP BY building
		HAVING MAX(QTY)
		ORDER by QTY DESC
		) AS TopTenant
	, (
		SELECT
			tenantreference
		FROM temptoptenant T6
		WHERE areatype = "Common"
			AND T1.building = T6.building
--			AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
--				BETWEEN DATE('now','start of month','-1 month') AND DATE('now','start of month', '-1 day')
		GROUP BY building
		HAVING MAX(QTY)
		ORDER by QTY DESC
		) AS TopCommon
		,	(
			SELECT
			 	QTY
			FROM tempTopTenant T7
			WHERE T7.TenantReference IN (
					SELECT T8.TenantReference
					FROM temptoptenant T8
					WHERE T7.building = T8.building
						AND  T8.areatype = "Tenant"
					GROUP BY T8.building, T8.QTY
					ORDER by T8.QTY DESC
					LIMIT 1 OFFSET 2
				)
				AND T1.building = T7.building
		) AS TopTenantQty3rdRank
		,	(
			SELECT
			 	QTY
			FROM tempTopTenant T9
			WHERE T9.TenantReference IN (
					SELECT T10.TenantReference
					FROM temptoptenant T10
					WHERE T9.building = T10.building
						AND  T10.areatype = "Common"
					GROUP BY T10.building, T10.QTY
					ORDER by T10.QTY DESC
					LIMIT 1 OFFSET 2
				)
				AND T1.building = T9.building
		) AS TopCommonQty3rdRank
	, (SELECT monthFullName || ' ' || strftime('%Y', 'now') FROM MonthOfYear WHERE monthID = strftime('%m', 'now', '-1 month')  ) as MonthYear
from BuildingData T1
where isactive = "Active"
group by building
order by building;

-- Fill in Null Quantity with 1
Update tempEvoMonthlyReport SET TopTenantQty3rdRank = 1 WHERE TopTenantQty3rdRank IS NULL;
Update tempEvoMonthlyReport SET TopCommonQty3rdRank = 1 WHERE TopCommonQty3rdRank IS NULL;
Update tempEvoMonthlyReport SET TopCommon =  '-' WHERE TopCommon IS NULL;
Update tempEvoMonthlyReport SET TopTenant =  '-' WHERE TopTenant IS NULL;
----------- START Table : tempEvoMonthlyReport ---------------



-------------- End of Report Query ----------------------------------




----------------------------------------------------------------------
--------------------- Query Data for GRAPH ---------------------------
-- Prepare Data for Graph
-- Table Name : -
-- Query Name : Query_LastMFaultCode
-- Report Name : Report_LastMFaultCode
-- Created 8/09/2018 by Khemmachat Mangkornsaksit
-- Modified 22/09/2018 by Khemmachat Mangkornsaksit
-- BUG : -

SELECT
	 Building
 , IFNULL(FaultCode,'-') FaultCode
 ,	QTY
 , Month
 , Year
 , '(' || ROUND(QTY *100.0 / (SELECT SUM(QTY) FROM FaultCodesCountbyMonth T2 WHERE T1.building = T2.building GROUP BY building), 1) || '%)' AS Percent
FROM
 FaultCodesCountbyMonth T1
GROUP BY
	 building
 , FaultCode
ORDER BY
 building


--------------------- PLOT GRAPH ---------------------------
-- Plot Graph Number of Order according to Fault Code
-- Table Name : -
-- Query Name : -
-- Report Name : Report_LastMFaultCode
-- Created 22/09/2018 by Khemmachat Mangkornsaksit
-- Modified 22/09/2018 by Khemmachat Mangkornsaksit
-- BUG : -
select QTY, '-' AS A from FaultCodesCountbyMonth where faultcode is null and building = '$F(building)' UNION
select QTY, 'Air Condition System' AS A from FaultCodesCountbyMonth where faultcode like "%Air%" and building = '$F(building)' UNION
select QTY, 'Complain' AS A from FaultCodesCountbyMonth where faultcode like "%Complain%" and building = '$F(building)' UNION
select QTY, 'Electrical System' AS A from FaultCodesCountbyMonth where faultcode like "%Electrical%" and building = '$F(building)' UNION
select QTY, 'General' AS A from FaultCodesCountbyMonth where faultcode like "%General%" and building = '$F(building)' UNION
select QTY, 'Sanitary System' AS A from FaultCodesCountbyMonth where faultcode like "%Sanitary%" and building = '$F(building)' ORDER BY A

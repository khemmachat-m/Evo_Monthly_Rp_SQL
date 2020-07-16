------------------ START OF SECTION 1 ---------------------

-- 1.1) Duplicate Table TaskPPM and Change its Name to EngPPM

-- 1.2) Delete the building that not like 'Common Area' such as 'Tenant' or 'Co Owner'
DELETE
FROM EngPPM
WHERE building not like '%common area%';

-- 2.2) Delete lower frequency Tasks that be dropped (History) by the system
DELETE
FROM EngPPM
WHERE notes LIKE "%was not issued%";

-- 2.3) Chenage Status from "HISTORY" to "COMPLETE"
UPDATE EngPPM
SET status = replace(status,"HISTORY","COMPLETE");

------------------ END OF SECTION 1 ---------------------




------------------- START OF SECTION 2 -----------------------
-- 2) Manipulate Data
-- 2.1) Create Table for store PPM Order Status by Month
CREATE TABLE IF NOT EXISTS 'TempEngPPMOrderStatusByMonth' (
	'Building' TEXT,
	'Status' TEXT,
	'QTY' NUMERIC,
	'Month' NUMERIC,
	'Year' NUMERIC
);

-- 2.2) Count Number of Active and Complete Order of each month and put the result into the Table
-- Table Name : TempEngPPMOrderStatusByMonth
-- Create 10/01/2020 by Khemmachat Mangkornsaksit
-- Modified 10/01/2020 by Khemmachat Mangkornsaksit
-- BUG :
--------------------------------------------------------
--| Building           | Status   | QTY | Month | Year |
--------------------------------------------------------
--| AIA SATHORN TOWER	 | COMPLETE |	 84	|	 	8		| 2018 |
--| AIA SATHORN TOWER	 | COMPLETE	|  75	| 	8		|	2018 |
--| AIA SATHORN TOWER	 | ACTIVE		|  0	|  	8		|	2018 |
--------------------------------------------------------
DELETE FROM TempEngPPMOrderStatusByMonth;
INSERT INTO TempEngPPMOrderStatusByMonth
	SELECT
		building
		, status
		, count(status) as Qty
		,	strftime('%m',DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2)) ) AS month
		,	strftime('%Y',DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2)) ) AS Year
	FROM
	EngPPM
		where
		DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
--				BETWEEN DATE('now','start of year', '-1 year') AND DATE('now','start of month', '-1 day') -- for Dec Only
				BETWEEN DATE('now','start of year') AND DATE('now','start of month', '-1 day')
		and building in (
			select BldgNameEngPPM from BuildingData where IsEngPPMActive = 1)
	GROUP BY building, status, month
	ORDER BY building, year, month, status;


------------------- END OF SECTION 2 -----------------------


------------------- START OF SECTION 3 -----------------------

-- 3.1) Create Temporary Table
--CREATE TEMPORARY TABLE IF NOT EXISTS tempActiveBuilding2
CREATE TABLE IF NOT EXISTS tempMonthlyEngPPM
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

-- 3.2) Create Temporary Table
DELETE FROM tempMonthlyEngPPM;
INSERT INTO tempMonthlyEngPPM
	SELECT
  	  BldgNameEngPPM
		, BldgShortName
    , Status
    , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	FROM
 		BuildingData
  JOIN OrderStatus
  WHERE IsEngPPMActive = 1 -- 1 = Active
  ORDER BY building;

-- 3.3) Assign QTY Value to temporary TABLE
	UPDATE tempMonthlyEngPPM
	SET JanQty =
			(
			select
			-- case when countstatus is null then 0 else countstatus end
			-- case when QTY IS NULL then 0 else QTY end
			CASE WHEN strftime('%m','now') = '01' then 0 else QTY end
			from TempEngPPMOrderStatusByMonth
			where building = tempMonthlyEngPPM.BUILDING
				and status = tempMonthlyEngPPM.Status
				AND TempEngPPMOrderStatusByMonth.Month = 1
	--		  AND TempEngPPMOrderStatusByMonth.Year = strftime('%Y','now')
			 )
		, FebQty =
	    (
			select
			-- case when countstatus is null then 0 else countstatus end
			-- case when QTY IS NULL then 0 else QTY end
			CASE WHEN strftime('%m','now') = '02' then 0 else QTY end
			from TempEngPPMOrderStatusByMonth
			where building = tempMonthlyEngPPM.BUILDING
				and status = tempMonthlyEngPPM.Status
				AND TempEngPPMOrderStatusByMonth.Month = 2
	--			AND TempEngPPMOrderStatusByMonth.Year = strftime('%Y','now')
	    )
		, MarQty =
	    (
			select
			-- case when countstatus is null then 0 else countstatus end
			-- case when QTY IS NULL then 0 else QTY end
			CASE WHEN strftime('%m','now') = '03' then 0 else QTY end
			from TempEngPPMOrderStatusByMonth
			where building = tempMonthlyEngPPM.BUILDING
				and status = tempMonthlyEngPPM.Status
				AND TempEngPPMOrderStatusByMonth.Month = 3
	--			AND TempEngPPMOrderStatusByMonth.Year = strftime('%Y','now')
	    )
		, AprQty =
	    (
			select
			-- case when countstatus is null then 0 else countstatus end
			-- case when QTY IS NULL then 0 else QTY end
			CASE WHEN strftime('%m','now') = '04' then 0 else QTY end
			from TempEngPPMOrderStatusByMonth
			where building = tempMonthlyEngPPM.BUILDING
				and status = tempMonthlyEngPPM.Status
				AND TempEngPPMOrderStatusByMonth.Month = 4
	--			AND TempEngPPMOrderStatusByMonth.Year = strftime('%Y','now')
	    )
		, MayQty =
	    (
			select
			-- case when countstatus is null then 0 else countstatus end
			-- case when QTY IS NULL then 0 else QTY end
			CASE WHEN strftime('%m','now') = '05' then 0 else QTY end
			from TempEngPPMOrderStatusByMonth
			where building = tempMonthlyEngPPM.BUILDING
				and status = tempMonthlyEngPPM.Status
				AND TempEngPPMOrderStatusByMonth.Month = 5
	--			AND TempEngPPMOrderStatusByMonth.Year = strftime('%Y','now')
	    )
		, JunQty =
	    (
			select
			-- case when countstatus is null then 0 else countstatus end
			-- case when QTY IS NULL then 0 else QTY end
			CASE WHEN strftime('%m','now') = '06' then 0 else QTY end
			from TempEngPPMOrderStatusByMonth
			where building = tempMonthlyEngPPM.BUILDING
				and status = tempMonthlyEngPPM.Status
				AND TempEngPPMOrderStatusByMonth.Month = 6
	--			AND TempEngPPMOrderStatusByMonth.Year = strftime('%Y','now')
	    )
		, JulQty =
	    (
			select
			-- case when countstatus is null then 0 else countstatus end
			-- case when QTY IS NULL then 0 else QTY end
			CASE WHEN strftime('%m','now') = '07' then 0 else QTY end
			from TempEngPPMOrderStatusByMonth
			where building = tempMonthlyEngPPM.BUILDING
				and status = tempMonthlyEngPPM.Status
				AND TempEngPPMOrderStatusByMonth.Month = 7
	--			AND TempEngPPMOrderStatusByMonth.Year = strftime('%Y','now')
	    )
		, AugQty =
	    (
			select
			-- case when countstatus is null then 0 else countstatus end
			-- case when QTY IS NULL then 0 else QTY end
			CASE WHEN strftime('%m','now') = '08' then 0 else QTY end
			from TempEngPPMOrderStatusByMonth
			where building = tempMonthlyEngPPM.BUILDING
				and status = tempMonthlyEngPPM.Status
				AND TempEngPPMOrderStatusByMonth.Month = 8
	--			AND TempEngPPMOrderStatusByMonth.Year = strftime('%Y','now')
	    )
		, SepQty =
	    (
			select
			-- case when countstatus is null then 0 else countstatus end
			-- case when QTY IS NULL then 0 else QTY end
			CASE WHEN strftime('%m','now') = '09' then 0 else QTY end
			from TempEngPPMOrderStatusByMonth
			where building = tempMonthlyEngPPM.BUILDING
				and status = tempMonthlyEngPPM.Status
				AND TempEngPPMOrderStatusByMonth.Month = 9
	--			AND TempEngPPMOrderStatusByMonth.Year = strftime('%Y','now')
	    )
		, OctQty =
	    (
			select
			-- case when countstatus is null then 0 else countstatus end
			-- case when QTY IS NULL then 0 else QTY end
			CASE WHEN strftime('%m','now') = '10' then 0 else QTY end
			from TempEngPPMOrderStatusByMonth
			where building = tempMonthlyEngPPM.BUILDING
				and status = tempMonthlyEngPPM.Status
				AND TempEngPPMOrderStatusByMonth.Month = 10
	--			AND TempEngPPMOrderStatusByMonth.Year = strftime('%Y','now')
	    )
		, NovQty =
	    (
			select
			-- case when countstatus is null then 0 else countstatus end
			-- case when QTY IS NULL then 0 else QTY end
			CASE WHEN strftime('%m','now') = '11' then 0 else QTY end
			from TempEngPPMOrderStatusByMonth
			where building = tempMonthlyEngPPM.BUILDING
				and status = tempMonthlyEngPPM.Status
				AND TempEngPPMOrderStatusByMonth.Month = 11
	--			AND TempEngPPMOrderStatusByMonth.Year = strftime('%Y','now')
	    )
		, DecQty =
	    (
			select
			-- case when countstatus is null then 0 else countstatus end
			-- case when QTY IS NULL then 0 else QTY end
			CASE WHEN strftime('%m','now') = '12' then 0 else QTY end
			from TempEngPPMOrderStatusByMonth
			where building = tempMonthlyEngPPM.BUILDING
				and status = tempMonthlyEngPPM.Status
				AND TempEngPPMOrderStatusByMonth.Month = 12
	--		  AND TempEngPPMOrderStatusByMonth.Year = strftime('%Y','now')
	    )
			, Total =
		 	(
	 		SELECT
	      sum(qty)
	 		FROM TempEngPPMOrderStatusByMonth
	 		WHERE building = tempMonthlyEngPPM.BUILDING
	 			AND status = tempMonthlyEngPPM.Status
	-- 			AND TempEngPPMOrderStatusByMonth.Year = strftime('%Y','now')
				AND TempEngPPMOrderStatusByMonth.month <> strftime('%m', 'now')
		 	);

-- 3.4) Assign 0 to record that Qty is NULL
	UPDATE tempMonthlyEngPPM SET JanQty = 0 WHERE JanQty IS NULL;
	UPDATE tempMonthlyEngPPM SET FebQty = 0 WHERE FebQty IS NULL;
	UPDATE tempMonthlyEngPPM SET MarQty = 0 WHERE MarQty IS NULL;
	UPDATE tempMonthlyEngPPM SET AprQty = 0 WHERE AprQty IS NULL;
	UPDATE tempMonthlyEngPPM SET MayQty = 0 WHERE MayQty IS NULL;
	UPDATE tempMonthlyEngPPM SET JunQty = 0 WHERE JunQty IS NULL;
	UPDATE tempMonthlyEngPPM SET JulQty = 0 WHERE JulQty IS NULL;
	UPDATE tempMonthlyEngPPM SET AugQty = 0 WHERE AugQty IS NULL;
	UPDATE tempMonthlyEngPPM SET SepQty = 0 WHERE SepQty IS NULL;
	UPDATE tempMonthlyEngPPM SET OctQty = 0 WHERE OctQty IS NULL;
	UPDATE tempMonthlyEngPPM SET NovQty = 0 WHERE NovQty IS NULL;
	UPDATE tempMonthlyEngPPM SET DecQty = 0 WHERE DecQty IS NULL;
	UPDATE tempMonthlyEngPPM SET Total = 0 WHERE Total IS NULL;


------------------- END OF SECTION 3 -----------------------

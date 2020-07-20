-- 1) Create Table TASkPPM by Import CSV File
-- 1.1) Change Type of All Fields to TEXT

--------------- START OF SECTION 2 ---------------------------------
-- 2) Correct Data before using it
-- 2.1) Change Building Name "AIA Sathorn Tower" to "AIA SATHORN TOWER"
UPDATE TASkPPM
SET
	building = replace(building,"AIA Sathorn Tower","AIA SATHORN TOWER")
WHERE
	building = "AIA Sathorn Tower";

-- 2.2) Delete Data of Demo Building
DELETE
FROM
	TASkPPM
WHERE
	building LIKE "%Demo%";

-- 2.2) Delete Data of Engineering PPM
DELETE
FROM
 taskPPM
WHERE
 building LIKE "%- common area%";

-- 2.3) Chenage Status from "HISTORY" to "COMPLETE"
UPDATE TASkPPM
SET status = replace(status,"HISTORY","COMPLETE");

-- 2.4) Add TypeOfPPM column in the TASkPPM Table
ALTER TABLE TASkPPM
	ADD 'TypeOfPPM' TEXT;

-- 2.5) Fill In TypeOfPPM
Update TASkPPM set TypeOfPPM = "ADMN" WHERE System = 'ACTR' AND Tag = 'ACTR'; -- Contract Management
UPDATE TASkPPM SET TypeOfPPM = "ACMP" WHERE System = 'ADMN' AND Tag = 'ACMP'; -- Law and Regulation
UPDATE TASkPPM SET TypeOfPPM = "LIFE" WHERE System = 'LIFE' AND (Tag = 'LEVA' OR Tag = 'LTRN'); -- Safety
update TASkPPM set TypeOfPPM = "LIFE" where System = 'SUST' AND Tag = 'CASS'; -- Safety
Update TASkPPM SET TypeOfPPM = "SUST" WHERE System = 'SUST' AND Tag = 'CWMS'; -- Sustainability
UPDATE TASkPPM set TypeOfPPM = "CLNG" WHERE System = 'CLNG' AND Tag = 'CHYG'; -- Cleaning
update TASkPPM set TypeOfPPM = "GGLS" WHERE System = 'GENM' AND Tag = 'GGLS'; -- Garden
update TASkPPM set TypeOfPPM = "SECU" WHERe System = 'SECU' AND Tag = 'SMON'; -- Security
update TASkPPM set TypeOfPPM = "ACCT" WHERE System = 'ADMN' AND Tag = 'ASTR'; -- Accountant
update TASkPPM set TypeOfPPM = "EVNT" WHERE System = 'ESSS' AND (Tag = 'ECMP' OR Tag = 'AMTG'); -- Events
Update TASkPPM set TypeOfPPM = "ACMG" WHERE System = 'ADMN' AND Tag = 'ACMG'; -- Contractor Management
update TASkPPM Set TypeOfPPM = "ENGR" Where TypeOfPPM is null;


-- 2.6) Modify Column Name from Evo V5 to Evo V4
ALTER TABLE TaskPPM
	RENAME COLUMN TaskType to Type;
ALTER TABLE TaskPPM
	RENAME COLUMN TaskReportedDate to ReportedDate;


--------------- END OF SECTION 2 ---------------------------------

--------------- START SECTION 3 ---------------------------------
-- 3) Count Active and Complete PPM Order of LASt Month
-- Table Name : -
-- DatASource : -
-- Report : -
-- Create 25/09/2018 by Khemmachat Mangkornsaksit
-- Modified 25/09/2018 by Khemmachat Mangkornsaksit
-- BUG :
--------------------------------------------------
--|    BUILDING	   		|  Status   | Jan | Feb |
--------------------------------------------------
--| AIA SATHORN TOWER	|  ACTIVE 	|  0  |  0  |
--| AIA SATHORN TOWER	| COMPLETE 	| 131 |  79 |
--------------------------------------------------

-- 3.1) Create Temporary Table
--CREATE TEMPORARY TABLE IF NOT EXISTS tempActiveBuilding
CREATE TABLE IF NOT EXISTS tempPPMPerformRp
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
	DELETE FROM tempPPMPerformRp;
	INSERT INTO tempPPMPerformRp
	SELECT
		  Building
		, BldgShortName
	  , Status
	  , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	FROM
			BuildingData
	JOIN OrderStatus
	WHERE IsBldgOPActive = "Active"
	ORDER BY building;

	-- 2.3) Assign QTY Value to temporary TABLE
	UPDATE tempPPMPerformRp
	SET	JanQty =
			(
			SELECT
				COUNT(AssetDescription) AS LAStMPPM
			FROM TASkPPM
			WHERE
				building = tempPPMPerformRp.building
				AND Status = tempPPMPerformRp.Status
				--AND Type = "PPM"
				AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
					BETWEEN STRFTIME('%Y','now') || '-01-01' AND STRFTIME('%Y','now') || '-01-31'
	--				AND Tag = "ACMG"
			GROUP BY Building, Status
			)
	,	FebQty =
			(
			SELECT
				COUNT(AssetDescription) AS LAStMPPM
			FROM TASkPPM
			WHERE
				building = tempPPMPerformRp.building
				AND Status = tempPPMPerformRp.Status
				--AND Type = "PPM"
				AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
					BETWEEN STRFTIME('%Y','now') || '-02-01' AND STRFTIME('%Y','now') || '-02-28'
	--				AND Tag = "ACMG"
			GROUP BY Building, Status
			)
	,	MarQty =
			(
			SELECT
				COUNT(AssetDescription) AS LAStMPPM
			FROM TASkPPM
			WHERE
				building = tempPPMPerformRp.building
				AND Status = tempPPMPerformRp.Status
				--AND Type = "PPM"
				AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
					BETWEEN STRFTIME('%Y','now') || '-03-01' AND STRFTIME('%Y','now') || '-03-31'
	--				AND Tag = "ACMG"
			GROUP BY Building, Status
			)
	,	AprQty =
			(
			SELECT
				COUNT(AssetDescription) AS LAStMPPM
			FROM TASkPPM
			WHERE
				building = tempPPMPerformRp.building
				AND Status = tempPPMPerformRp.Status
				--AND Type = "PPM"
				AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
					BETWEEN STRFTIME('%Y','now') || '-04-01' AND STRFTIME('%Y','now') || '-04-30'
	--				AND Tag = "ACMG"
			GROUP BY Building, Status
			)
	,	MayQty =
			(
			SELECT
				COUNT(AssetDescription) AS LAStMPPM
			FROM TASkPPM
			WHERE
				building = tempPPMPerformRp.building
				AND Status = tempPPMPerformRp.Status
				--AND Type = "PPM"
				AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
					BETWEEN STRFTIME('%Y','now') || '-05-01' AND STRFTIME('%Y','now') || '-05-31'
	--				AND Tag = "ACMG"
			GROUP BY Building, Status
			)
	,	JunQty =
			(
			SELECT
				COUNT(AssetDescription) AS LAStMPPM
			FROM TASkPPM
			WHERE
				building = tempPPMPerformRp.building
				and Status = tempPPMPerformRp.Status
				--AND Type = "PPM"
				AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
					BETWEEN STRFTIME('%Y','now') || '-06-01' AND STRFTIME('%Y','now') || '-06-30'
	--				AND Tag = "ACMG"
			GROUP BY Building, Status
			)
	,	JulQty =
			(
			SELECT
				COUNT(AssetDescription) AS LAStMPPM
			FROM TASkPPM
			WHERE
				building = tempPPMPerformRp.building
				AND Status = tempPPMPerformRp.Status
				--AND Type = "PPM"
				AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
					BETWEEN STRFTIME('%Y','now') || '-07-01' AND STRFTIME('%Y','now') || '-07-31'
	--				AND Tag = "ACMG"
			GROUP BY Building, Status
			)
	,	AugQty =
			(
			SELECT
				COUNT(AssetDescription) AS LAStMPPM
			FROM TASkPPM
			WHERE
				building = tempPPMPerformRp.building
				AND Status = tempPPMPerformRp.Status
				--AND Type = "PPM"
				AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
					BETWEEN STRFTIME('%Y','now') || '-08-01' AND STRFTIME('%Y','now') || '-08-31'
	--				AND Tag = "ACMG"
			GROUP BY Building, Status
			)
	,	SepQty =
			(
			SELECT
				COUNT(AssetDescription) AS LAStMPPM
			FROM TASkPPM
			WHERE
				building = tempPPMPerformRp.building
				AND Status = tempPPMPerformRp.Status
				--AND Type = "PPM"
				AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
					BETWEEN STRFTIME('%Y','now') || '-09-01' AND STRFTIME('%Y','now') || '-09-30'
	--				AND Tag = "ACMG"
			GROUP BY Building, Status
			)
	,	OctQty =
			(
			SELECT
				COUNT(AssetDescription) AS LAStMPPM
			FROM TASkPPM
			WHERE
				building = tempPPMPerformRp.building
				AND Status = tempPPMPerformRp.Status
				--AND Type = "PPM"
				AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
					BETWEEN STRFTIME('%Y','now') || '-10-01' AND STRFTIME('%Y','now') || '-10-31'
	--				AND Tag = "ACMG"
			GROUP BY Building, Status
			)
	,	NovQty =
			(
			SELECT
				COUNT(AssetDescription) AS LAStMPPM
			FROM TASkPPM
			WHERE
				building = tempPPMPerformRp.building
				AND Status = tempPPMPerformRp.Status
				--AND Type = "PPM"
				AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
					BETWEEN STRFTIME('%Y','now') || '-11-01' AND STRFTIME('%Y','now') || '-11-30'
	--				AND Tag = "ACMG"
			GROUP BY Building, Status
			)
	,	DecQty =
			(
			SELECT
				COUNT(AssetDescription) AS LAStMPPM
			FROM TASkPPM
			WHERE
				building = tempPPMPerformRp.building
				AND Status = tempPPMPerformRp.Status
				--AND Type = "PPM"
				AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
					BETWEEN STRFTIME('%Y','now') || '-12-01' AND STRFTIME('%Y','now') || '-12-31'
	--				AND Tag = "ACMG"
			GROUP BY Building, Status
			)
	,	Total =
			(
			SELECT
				COUNT(AssetDescription) AS LAStMPPM
			FROM TASkPPM
			WHERE
				building = tempPPMPerformRp.building
				AND Status = tempPPMPerformRp.Status
				--AND Type = "PPM"
				AND DATE(substr("ReportedDate", 7, 4) || '-' || substr("ReportedDate", 4, 2) || '-' || substr("ReportedDate", 1, 2))
					BETWEEN STRFTIME('%Y','now') || '-01-01' AND STRFTIME('%Y','now') || '-12-31'
	--				AND Tag = "ACMG"
			GROUP BY Building, Status
			);

-- 3.4) Assign 0 to record that Qty is NULL
UPDATE tempPPMPerformRp SET JanQty = 0 WHERE JanQty IS NULL;
UPDATE tempPPMPerformRp SET FebQty = 0 WHERE FebQty IS NULL;
UPDATE tempPPMPerformRp SET MarQty = 0 WHERE MarQty IS NULL;
UPDATE tempPPMPerformRp SET AprQty = 0 WHERE AprQty IS NULL;
UPDATE tempPPMPerformRp SET MayQty = 0 WHERE MayQty IS NULL;
UPDATE tempPPMPerformRp SET JunQty = 0 WHERE JunQty IS NULL;
UPDATE tempPPMPerformRp SET JulQty = 0 WHERE JulQty IS NULL;
UPDATE tempPPMPerformRp SET AugQty = 0 WHERE AugQty IS NULL;
UPDATE tempPPMPerformRp SET SepQty = 0 WHERE SepQty IS NULL;
UPDATE tempPPMPerformRp SET OctQty = 0 WHERE OctQty IS NULL;
UPDATE tempPPMPerformRp SET NovQty = 0 WHERE NovQty IS NULL;
UPDATE tempPPMPerformRp SET DecQty = 0 WHERE DecQty IS NULL;
UPDATE tempPPMPerformRp SET Total = 0 WHERE Total IS NULL;

-- 3.5) Sum Total PPM Order
INSERT INTO tempPPMPerformRp
SELECT
	  building
	, BldgShortName
	, "ALL" AS Status
	, sum(JanQty) AS JanQty
	, sum(FebQty) AS FebQty
	, sum(MarQty) AS MarQty
	, sum(AprQty) AS AprQty
	, sum(MayQty) AS MayQty
	, sum(JunQty) AS JunQty
	, sum(JulQty) AS JulQty
	, sum(AugQty) AS AugQty
	, sum(SepQty) AS SepQty
	, sum(OctQty) AS OctQty
	, sum(NovQty) AS NovQty
	, sum(DecQty) AS DecQty
	, sum(Total) AS Total
FROM
	tempPPMPerformRp
GROUP BY
	building;


--------------- END OF SECTION 3 ---------------------------------

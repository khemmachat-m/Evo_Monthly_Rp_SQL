
"""
SQLITE Editor

Created on Sunday, August 30 2020

@author: khemmachat
"""

-- 1.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_CHW_LEV_TEMP' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
CHW_LEV_TEMP 'REAL'
);

-- 1.2) Fill in the Table
DELETE FROM CH_CHW_LEV_TEMP;
INSERT INTO CH_CHW_LEV_TEMP

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "LEAVING-CHW-TEMP";


-- 2.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_CHW_ENT_TEMP' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
CHW_ENT_TEMP 'REAL'
);

-- 2.2) Fill in the Table
DELETE FROM CH_CHW_ENT_TEMP;
INSERT INTO CH_CHW_ENT_TEMP

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "ENTERING-CHW-TEMP";


-- 3.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_EVAP_SAT_TEMP' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
EVAP_SAT_TEMP 'REAL'
);

-- 3.2) Fill in the Table
DELETE FROM CH_EVAP_SAT_TEMP;
INSERT INTO CH_EVAP_SAT_TEMP

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "EVAP-SATURATION-TEMP";



-- 4.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_VSD_KW' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
VSD_KW 'REAL'
);

-- 4.2) Fill in the Table
DELETE FROM CH_VSD_KW;
INSERT INTO CH_VSD_KW

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "VSD-INPUT-KW";


-- 5.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_COND_LEV_TEMP' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
COND_LEV_TEMP 'REAL'
);

-- 5.2) Fill in the Table
DELETE FROM CH_COND_LEV_TEMP;
INSERT INTO CH_COND_LEV_TEMP

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "LEAVING-COND-WATER-TEMP";


-- 6.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_COND_SAT_TEMP' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
COND_SAT_TEMP 'REAL'
);

-- 6.2) Fill in the Table
DELETE FROM CH_COND_SAT_TEMP;
INSERT INTO CH_COND_SAT_TEMP

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "COND-SATURATION-TEMP";


-- 7.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_COND_ENT_TEMP' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
COND_ENT_TEMP 'REAL'
);

-- 7.2) Fill in the Table
DELETE FROM CH_COND_ENT_TEMP;
INSERT INTO CH_COND_ENT_TEMP

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "ENTERING-COND-WATER-TEMP";


-- 8.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_MOTOR_CURRENT_A' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
MOTOR_Current_A 'REAL'
);

-- 8.2) Fill in the Table
DELETE FROM CH_MOTOR_CURRENT_A;
INSERT INTO CH_MOTOR_CURRENT_A

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "PHASE-A-MOTOR-CURRENT";


-- 9.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_MOTOR_CURRENT_B' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
MOTOR_Current_B 'REAL'
);

-- 9.2) Fill in the Table
DELETE FROM CH_MOTOR_CURRENT_B;
INSERT INTO CH_MOTOR_CURRENT_B

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "PHASE-B-MOTOR-CURRENT";


-- 10.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_MOTOR_CURRENT_C' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
MOTOR_Current_C 'REAL'
);

-- 10.2) Fill in the Table
DELETE FROM CH_MOTOR_CURRENT_C;
INSERT INTO CH_MOTOR_CURRENT_C

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "PHASE-C-MOTOR-CURRENT";


-- 11.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_MOTOR_CURRENT_FLA' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
MOTOR_Current_FLA 'REAL'
);

-- 11.2) Fill in the Table
DELETE FROM CH_MOTOR_CURRENT_FLA;
INSERT INTO CH_MOTOR_CURRENT_FLA

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "MOTOR-CURRENT-PCT-FLA";


-- 12.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_DISCHARGE_TEMP' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
DISCHARGE_TEMP 'REAL'
);

-- 12.2) Fill in the Table
DELETE FROM CH_DISCHARGE_TEMP;
INSERT INTO CH_DISCHARGE_TEMP

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "DISCHARGE-TEMP";


-- 13.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_OIL_SUMP_PRESS' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
OIL_SUMP_PRESS 'REAL'
);

-- 13.2) Fill in the Table
DELETE FROM CH_OIL_SUMP_PRESS;
INSERT INTO CH_OIL_SUMP_PRESS

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "OIL-SUMP-PRESSURE";


-- 14.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_OIL_SUMP_TEMP' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
OIL_SUMP_TEMP 'REAL'
);

-- 14.2) Fill in the Table
DELETE FROM CH_OIL_SUMP_TEMP;
INSERT INTO CH_OIL_SUMP_TEMP

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "OIL-SUMP-TEMPERATURE";


-- 15.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_VSD_FREQ' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
VSD_FREQ 'REAL'
);

-- 15.2) Fill in the Table
DELETE FROM CH_VSD_FREQ;
INSERT INTO CH_VSD_FREQ

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "VSD-OUTPUT-FREQUENCY";


-- 16.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_MOTOR_TEMP' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
MOTOR_TEMP 'REAL'
);

-- 16.2) Fill in the Table
DELETE FROM CH_MOTOR_TEMP;
INSERT INTO CH_MOTOR_TEMP

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "MTR-WINDING-AVG-TEMP";


-- 17.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_COND_PRESS' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
COND_PRESS 'REAL'
);

-- 17.2) Fill in the Table
DELETE FROM CH_COND_PRESS;
INSERT INTO CH_COND_PRESS

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "CONDENSER-PRESSURE";


-- 18.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CH_EVAP_PRESS' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
EVAP_PRESS 'REAL'
);

-- 18.2) Fill in the Table
DELETE FROM CH_EVAP_PRESS;
INSERT INTO CH_EVAP_PRESS

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "EVAPORATOR-PRESSURE";


-- 19.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CPMS_RATED_TONS' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
CPMS_RATED_TONS 'REAL'
);

-- 19.2) Fill in the Table
DELETE FROM CPMS_RATED_TONS;
INSERT INTO CPMS_RATED_TONS

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "CH-TONS";


-- 20.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CPMS_BLD_TON' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
CPMS_BLD_TON 'REAL'
);

-- 20.2) Fill in the Table
DELETE FROM CPMS_BLD_TON;
INSERT INTO CPMS_BLD_TON

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "BLD-TON";


-- 21.1) Create Table
CREATE TEMPORARY TABLE IF NOT EXISTS 'CPMS_CHW_FLOW' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
CPMS_CHW_FLOW 'REAL'
);

-- 21.2) Fill in the Table
DELETE FROM CPMS_CHW_FLOW;
INSERT INTO CPMS_CHW_FLOW

  SELECT
      DateTime
    , date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    , substr( "DateTime",12, 8)
    , EqNo
    , Value
  FROM CPMS
  WHERE (date(substr( "Date",1, 4) || '-' || substr("Date", 6, 2) || '-' || substr("Date", 9, 2))
    BETWEEN DATE('now','start of month','-6 month') AND date('now','start of month', '-1 day'))
    AND ObjectName = "FLOW";

----------------------
-- Combine all Table
----------------------
DROP TABLE IF EXISTS 'CPMS_NEW';

CREATE TABLE IF NOT EXISTS 'CPMS_New' (
ts 'TEXT',
ts_Date 'TEXT',
ts_Time 'TEXT',
EqNo 'TEXT',
CHW_ENT_TEMP 'REAL',
CHW_LEV_TEMP 'REAL',
COND_ENT_TEMP 'REAL',
COND_LEV_TEMP 'REAL',
COND_PRESS 'REAL',
COND_SAT_TEMP 'REAL',
DISCHARGE_TEMP 'REAL',
EVAP_PRESS 'REAL',
EVAP_SAT_TEMP 'REAL',
MOTOR_Current_A 'REAL',
MOTOR_Current_B 'REAL',
MOTOR_Current_C 'REAL',
MOTOR_Current_FLA 'REAL',
MOTOR_TEMP 'REAL',
OIL_SUMP_PRESS 'REAL',
OIL_SUMP_TEMP 'REAL',
VSD_FREQ 'REAL',
VSD_KW 'REAL',
CPMS_RATED_TONS 'REAL',
CPMS_BLD_TON 'REAL',
CPMS_CHW_FLOW 'REAL'
);

-- 19.2) Fill in the Table
DELETE FROM CPMS_New;
INSERT INTO CPMS_New

-- 19.3) Combine All Tables
SELECT
    T1.ts
  , T1.ts_Date
  , T1.ts_Time
  , T1.EqNo
  , T1.CHW_ENT_TEMP
  , T2.CHW_LEV_TEMP
  , T3.COND_ENT_TEMP
  , T4.COND_LEV_TEMP
  , T5.COND_PRESS
  , T6.COND_SAT_TEMP
  , T7.DISCHARGE_TEMP
  , T8.EVAP_PRESS
  , T9.EVAP_SAT_TEMP
  , T10.MOTOR_Current_A
  , T11.MOTOR_Current_B
  , T12.MOTOR_Current_C
  , T13.MOTOR_Current_FLA
  , T14.MOTOR_TEMP
  , T15.OIL_SUMP_PRESS
  , T16.OIL_SUMP_TEMP
  , T17.VSD_FREQ
  , T18.VSD_KW
  , T19.CPMS_RATED_TONS
  , T20.CPMS_BLD_TON
  , T21.CPMS_CHW_FLOW
FROM CH_CHW_ENT_TEMP    T1
JOIN CH_CHW_LEV_TEMP    T2 ON T1.ts = T2.ts AND T1.EqNo = T2.EqNo
JOIN CH_COND_ENT_TEMP   T3 ON T1.ts = T3.ts AND T1.EqNo = T3.EqNo
JOIN CH_COND_LEV_TEMP   T4 ON T1.ts = T4.ts AND T1.EqNo = T4.EqNo
JOIN CH_COND_PRESS      T5 ON T1.ts = T5.ts AND T1.EqNo = T5.EqNo
JOIN CH_COND_SAT_TEMP   T6 ON T1.ts = T6.ts AND T1.EqNo = T6.EqNo
JOIN CH_DISCHARGE_TEMP  T7 ON T1.ts = T7.ts AND T1.EqNo = T7.EqNo
JOIN CH_EVAP_PRESS      T8 ON T1.ts = T8.ts AND T1.EqNo = T8.EqNo
JOIN CH_EVAP_SAT_TEMP   T9 ON T1.ts = T9.ts AND T1.EqNo = T9.EqNo
JOIN CH_MOTOR_CURRENT_A T10 ON T1.ts = T10.ts AND T1.EqNo = T10.EqNo
JOIN CH_MOTOR_CURRENT_B T11 ON T1.ts = T11.ts AND T1.EqNo = T11.EqNo
JOIN CH_MOTOR_CURRENT_C T12 ON T1.ts = T12.ts AND T1.EqNo = T12.EqNo
JOIN CH_MOTOR_CURRENT_FLA T13 ON T1.ts = T13.ts AND T1.EqNo = T13.EqNo
JOIN CH_MOTOR_TEMP      T14 ON T1.ts = T14.ts AND T1.EqNo = T14.EqNo
JOIN CH_OIL_SUMP_PRESS  T15 ON T1.ts = T15.ts AND T1.EqNo = T15.EqNo
JOIN CH_OIL_SUMP_TEMP   T16 ON T1.ts = T16.ts AND T1.EqNo = T16.EqNo
JOIN CH_VSD_FREQ        T17 ON T1.ts = T17.ts AND T1.EqNo = T17.EqNo
JOIN CH_VSD_KW          T18 ON T1.ts = T18.ts AND T1.EqNo = T18.EqNo
-- FLOW & TONS will be combined with CH-01,02,03 already
JOIN CPMS_CHW_FLOW      T21 ON T1.ts = T21.ts
JOIN CPMS_RATED_TONS    T19 ON T1.ts = T19.ts AND T21.EqNo = T19.EqNo
JOIN CPMS_BLD_TON       T20 ON T1.ts = T20.ts AND T21.EqNo = T20.EqNo;





----- Data Processing -----------

SELECT
    ts
  , ts_Date
  , ts_Time
  , CASE
      WHEN strftime('%H', ts_Time) >= strftime('%H', '06:00:00') and strftime('%H', ts_Time) < strftime('%H', '09:00:00') THEN '6-9'
      WHEN strftime('%H', ts_Time) >= strftime('%H', '09:00:00') and strftime('%H', ts_Time) < strftime('%H', '12:00:00') THEN '9-12'
      WHEN strftime('%H', ts_Time) >= strftime('%H', '12:00:00') and strftime('%H', ts_Time) < strftime('%H', '17:00:00') THEN '12-17'
      WHEN strftime('%H', ts_Time) >= strftime('%H', '17:00:00') and strftime('%H', ts_Time) < strftime('%H', '21:00:00') THEN '17-21'
      WHEN strftime('%H', ts_Time) >= strftime('%H', '21:00:00') and strftime('%H', ts_Time) < strftime('%H', '24:00:00') THEN '21-24'
      ELSE '0-6'
    END AS ts_Period
  , substr( "ts",6, 2) As ts_Month
  , EqNo
  , CHW_ENT_TEMP - CHW_LEV_TEMP AS CHW_Temp_Diff
  , CHW_LEV_TEMP - (SELECT Temp_F FROM R134A_PT T3 WHERE ROUND(T3.PSIG) >= ROUND(T1.EVAP_PRESS) LIMIT 1) AS Approach_Temp_Evap
  , COND_LEV_TEMP - COND_ENT_TEMP AS COND_Temp_Diff
  , (SELECT Temp_F FROM R134A_PT T2 WHERE ROUND(T2.PSIG) >= ROUND(T1.COND_PRESS) LIMIT 1) - COND_LEV_TEMP AS Approach_Temp_Cond
  , COND_SAT_TEMP - (SELECT Temp_F FROM R134A_PT T2 WHERE ROUND(T2.PSIG) >= ROUND(T1.COND_PRESS) LIMIT 1) AS Ref_Cond_Subcooling
  , EVAP_SAT_TEMP - (SELECT Temp_F FROM R134A_PT T3 WHERE ROUND(T3.PSIG) >= ROUND(T1.EVAP_PRESS) LIMIT 1) AS Ref_Comp_Suc_Superheat
  , DISCHARGE_TEMP - (SELECT Temp_F FROM R134A_PT T2 WHERE ROUND(T2.PSIG) >= ROUND(T1.COND_PRESS) LIMIT 1) As Ref_Comp_Disc_Superheat
  , VSD_KW
  -- CH01,CH02 = 510kW, CH03 = 260kW, CH04, CH05 = 130kW
  , case EqNo
      WHEN "CH01" THEN printf('%.2f',VSD_KW/510.00*100)
      WHEN "CH02" THEN printf('%.2f',VSD_KW/510.00*100)
      WHEN "CH03" THEN printf('%.2f',VSD_KW/260.00*100)
      WHEN "CH04" THEN printf('%.2f',VSD_KW/130.00*100)
      WHEN "CH05" THEN printf('%.2f',VSD_KW/130.00*100)
    END AS VSD_KW_Percent
  , CHW_LEV_TEMP
  , CHW_ENT_TEMP
  , COND_ENT_TEMP
  , COND_LEV_TEMP
  , EVAP_SAT_TEMP
  , (SELECT Temp_F FROM R134A_PT T3 WHERE ROUND(T3.PSIG) >= ROUND(T1.EVAP_PRESS) LIMIT 1) AS EVAP_SAT_TEMP_REAL
  , EVAP_PRESS
  , COND_SAT_TEMP
  , (SELECT Temp_F FROM R134A_PT T2 WHERE ROUND(T2.PSIG) >= ROUND(T1.COND_PRESS) LIMIT 1) AS COND_SAT_TEMP_REAL
  , MOTOR_Current_A
  , OIL_SUMP_TEMP
  , OIL_SUMP_PRESS
  , (SELECT Temp_F FROM R134A_PT T2 WHERE ROUND(T2.PSIG) >= ROUND(T1.COND_PRESS) LIMIT 1) - (SELECT Temp_F FROM R134A_PT T3 WHERE ROUND(T3.PSIG) >= ROUND(T1.EVAP_PRESS) LIMIT 1) AS Refri_Temp_Diff
  , case EqNo
      WHEN "CH01" THEN printf('%d',850)
      WHEN "CH02" THEN printf('%d',850)
      WHEN "CH03" THEN printf('%d',400)
      WHEN "CH04" THEN printf('%d',200)
      WHEN "CH05" THEN printf('%d',200)
    END AS CH_RATED_TONS
  , CPMS_RATED_TONS
  , CPMS_BLD_TON
  , CPMS_CHW_FLOW
  , printf('%.2f',VSD_KW/CPMS_BLD_TON) AS kW_TON -- For review Chiller performance only
  , case EqNo
      WHEN "CH01" THEN printf('%.1f',CPMS_BLD_TON/850*100)
      WHEN "CH02" THEN printf('%.1f',CPMS_BLD_TON/850*100)
      WHEN "CH03" THEN printf('%.1f',CPMS_BLD_TON/400*100)
      WHEN "CH04" THEN printf('%.1f',CPMS_BLD_TON/200*100)
      WHEN "CH05" THEN printf('%.1f',CPMS_BLD_TON/200*100)
    END AS CH_TONS_Percent -- For review Chiller performance only
FROM CPMS_New T1
WHERE -- EqNo = "CH02" AND
  MOTOR_CURRENT_A > 10
  AND CPMS_RATED_TONS = CH_RATED_TONS -- For review chiller performance only

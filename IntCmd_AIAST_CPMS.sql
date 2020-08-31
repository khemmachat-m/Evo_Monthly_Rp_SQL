
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
VSD_KW 'REAL'
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
JOIN CH_VSD_KW          T18 ON T1.ts = T18.ts AND T1.EqNo = T18.EqNo;




----- Data Processing -----------

SELECT
    ts
  , ts_Date
  , ts_Time
  , substr( "ts",6, 2) As ts_Month
  , CHW_ENT_TEMP - CHW_LEV_TEMP AS CHW_Temp_Diff
  , CHW_LEV_TEMP - EVAP_SAT_TEMP AS Approach_Temp_Evap
  , COND_LEV_TEMP - COND_ENT_TEMP AS COND_Temp_Diff
  , COND_SAT_TEMP - COND_LEV_TEMP AS Approach_Temp_Cond
  , VSD_KW
  , CHW_LEV_TEMP
  , CHW_ENT_TEMP
  , COND_ENT_TEMP
  , COND_LEV_TEMP
  , EVAP_SAT_TEMP
  , COND_SAT_TEMP
  , MOTOR_Current_A
  , OIL_SUMP_TEMP
  , OIL_SUMP_PRESS
  , COND_SAT_TEMP - EVAP_SAT_TEMP AS Refri_Temp_Diff
FROM CPMS_New
WHERE EqNo = "CH01" AND MOTOR_CURRENT_A > 10

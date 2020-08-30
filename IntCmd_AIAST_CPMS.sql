
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

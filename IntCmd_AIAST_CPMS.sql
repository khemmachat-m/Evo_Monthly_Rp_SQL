


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

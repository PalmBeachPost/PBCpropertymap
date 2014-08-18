DROP TABLE IF EXISTS propertyshape_12_14;
CREATE TABLE propertyshape_12_14 (
  parid varchar PRIMARY KEY,
  primowner varchar,
  propcode varchar,
  propdesc varchar,
  unitcount int,
  mkt14 numeric,
  tax14 numeric,
  mkt13 numeric,
  tax13 numeric,
  mkt12 numeric,
  tax12 numeric,
  valchange_13_14 numeric,
  pctchange_13_14 numeric,
  geom geometry 
);

INSERT INTO propertyshape_12_14
select 
r14.parid,
r14.primowner,
r14.propcode,
r14.propdesc,
r14.unitcount,
r14.mktval,
r14.tax,
r13.mktval,
r13.tax,
r12.mktval,
r12.tax,
 (
    CASE
      WHEN r14.mktval <= 0
        THEN null
      ELSE
        r14.mktval-r13.mktval
    END
  )  AS valchh_13_14,
  (
    CASE
      WHEN r13.mktval <= 0
        THEN null
      ELSE
        ((r14.mktval-r13.mktval)*100) / r13.mktval
    END
  ) AS pctchh_13_14,
m.geom
FROM rollup_14 r14
INNER JOIN mergedshapes m ON r14.parid = m.parid
LEFT JOIN rollup_13 r13 ON r13.parid =r14.parid
LEFT JOIN rollup_12 r12 on r12.parid = r14.parid
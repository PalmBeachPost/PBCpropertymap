SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;

DROP TABLE IF EXISTS rollup_13;
CREATE TABLE rollup_13
(
  parid varchar,
  unitCount int,
  mktVal numeric,
  tax numeric,
  propCode varchar,
  propDesc varchar,
  primOwner varchar,
  PRIMARY KEY (parid)
);

CREATE INDEX idx_parid_13 ON rollup_13(parid);
CLUSTER rollup_13 USING idx_parid_13;

INSERT INTO rollup_13
  SELECT
    parid,
    1, 
    marketval,
    tax,
    code,
    descr,
    name
  FROM
  (SELECT DISTINCT parid from parcel) p 
  INNER JOIN property_13 pr ON p.parid = pr.pcn
  INNER JOIN tax_13 t ON pr.pcn = t.pcn
  INNER JOIN propuselookup pul ON pr.propertyuse = pul.code;

INSERT INTO rollup_13
SELECT
   subid,
   count(pcn),
   Avg(marketval),
   Avg(tax),
   Max(code),
   Max(descr),
   'Multiple owners'
   FROM
    (SELECT
     c.subid,
     pr.pcn,
     pr.marketval,
     t.tax,
     pul.code as code,
     pul.descr as descr
    FROM
     condos c 
     INNER JOIN property_13 pr ON substr(pr.pcn,0,11) LIKE c.subid
     INNER JOIN tax_13 t ON t.pcn = pr.pcn
     INNER JOIN propuselookup pul ON pr.propertyuse = pul.code
     ) tab
  GROUP BY subid;
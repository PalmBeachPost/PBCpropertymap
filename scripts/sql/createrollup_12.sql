SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;

DROP TABLE IF EXISTS rollup_12;
CREATE TABLE rollup_12
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

CREATE INDEX idx_parid_12 ON rollup_12(parid);
CLUSTER rollup_12 USING idx_parid_12;

INSERT INTO rollup_12
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
  INNER JOIN property_12 pr ON p.parid = pr.pcn
  INNER JOIN tax_12 t ON pr.pcn = t.pcn
  INNER JOIN propuselookup pul ON pr.propertyuse = pul.code;

INSERT INTO rollup_12
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
     INNER JOIN property_12 pr ON substr(pr.pcn,0,11) LIKE c.subid
     INNER JOIN tax_12 t ON t.pcn = pr.pcn
     INNER JOIN propuselookup pul ON pr.propertyuse = pul.code
     ) tab
  GROUP BY subid;
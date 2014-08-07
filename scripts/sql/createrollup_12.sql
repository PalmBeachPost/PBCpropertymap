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

CREATE INDEX idx_parid ON rollup_12(parid);
CLUSTER rollup_12 USING idx_parid;

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
  (SELECT DISTINCT parid from parcels) p 
  INNER JOIN property_13 pr ON p.parid = pr.pcn
  INNER JOIN tax_13 t ON pr.pcn = t.pcn
  INNER JOIN propuselookup pul ON pr.propertyuse = pul.code;

DELETE FROM rollup_12
WHERE parid IN 
(SELECT pcn FROM condodata);

INSERT INTO rollup_12
  SELECT
   parid,
   count(pcn),
   Avg(marketval),
   Avg(tax),
   Max(code),
   Max(descr),
   'Multiple owners'
   FROM
    (SELECT
     p.parid,
     c.pcn,
     pr.marketval,
     t.tax,
     pul.code as code,
     pul.descr as descr
    FROM
     parcels p
     INNER JOIN condodata c ON p.parid=c.condo_pcn
     INNER JOIN property_13 pr ON pr.pcn = c.pcn
     INNER JOIN tax_13 t ON t.pcn = pr.pcn
     INNER JOIN propuselookup pul ON pr.propertyuse = pul.code
     ) tab
  GROUP BY parid;
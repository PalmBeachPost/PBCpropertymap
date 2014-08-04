SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;

DROP TABLE IF EXISTS rollup_12;
CREATE TABLE rollup_12
(
  parid varchar,
  unitCount int,
  mktVal numeric,
  tax numeric,
  PRIMARY KEY (parid)
);

INSERT INTO rollup_12
  SELECT
    parid,
    1, 
    marketval,
    tax
  FROM
  (SELECT DISTINCT parid from parcels) p 
  INNER JOIN property_12 pr ON p.parid = pr.pcn
  INNER JOIN tax_12 t ON pr.pcn =t.pcn;

DELETE FROM rollup_12
WHERE parid IN 
(SELECT pcn FROM condodata);

INSERT INTO rollup_12
  SELECT
   parid,
   count(pcn),
   Avg(marketval),
   Avg(tax)
   FROM
    (SELECT
     p.parid,
     c.pcn,
     pr.marketval,
     t.tax
    FROM
     parcels p
     INNER JOIN condodata c ON p.parid=c.condo_pcn
     INNER JOIN property_12 pr ON pr.pcn = c.pcn
     INNER JOIN tax_12 t ON t.pcn = pr.pcn) tab
  GROUP BY parid;
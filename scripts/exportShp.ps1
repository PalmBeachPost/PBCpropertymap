param(
    $u ='postgres',
    $p = 5432,
    $db = 'propertydb',
    $table
)
$outpath = '..\propertyShp13'
pgsql2shp.exe -h localhost -u $u -p $p -f "propertyshp_12_13" $db "SELECT    
  r13.parid,
  r13.unitcount,
  r13.mktval AS mkt13,
  r13.tax AS tax13,
  r12.mktval AS mkt12,
  r12.tax AS tax12,
  (
    CASE
    WHEN r13.mktval <= 0
      null
    ELSE
      r13.mktval-r12.mktval
  ) AS AS valchh_12_13,
  (
    CASE
    WHEN r13.mktval <= 0
      null
    ELSE
      (r13.mktval-r12.mktval) / r12.mktval
  ) AS pctchh_12_13,
  (SELECT geom FROM parcels p WHERE p.parid = r13.parid LIMIT 1) AS geom
FROM rollup_13_2 r13 
LEFT JOIN rollup_12 r12 ON r13.parid = r12.parid"
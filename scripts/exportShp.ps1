param(
    $u ='postgres',
    $p = 5432,
    $db = 'propertydb',
    $table
)
$outpath = '..\propertyshpout'
pgsql2shp.exe -h localhost -u $u -p $p -f "propertyshp_14_12" $db "SELECT    
  r14.parid,
  r14.unitcount,
  r14.mktval AS mkt14,
  r14.tax AS tax14,
  r13.mktval AS mkt13,
  r13.tax AS tax13,
  r12.mktval AS mkt12,
  r12.tax AS tax12,
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
        (r14.mktval-r13.mktval) / r13.mktval
    END
  ) AS pctchh_13_14,
  (SELECT geom FROM parcels p WHERE p.parid = r14.parid LIMIT 1) AS geom
FROM rollup_14 r14 
LEFT JOIN rollup_13 r13 ON r14.parid = r13.parid
LEFT JOIN rollup_12 r12 ON r14.parid = r12.parid"
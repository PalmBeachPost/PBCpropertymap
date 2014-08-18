param(
    $u ='postgres',
    $p = 5432,
    $db = 'propertydb',
    $table
)

PSQL -U $u -h localhost -p $p -w -d $db -f ../parcelshape/createshapetable_12_14.sql

pgsql2shp.exe -h localhost -u $u -p $p -f "propertyshp_14_12" $db "SELECT    
  * FROM propertyshape_12_14
  WHERE parid NOT IN
  (
    SELECT pcn 
    FROM property_14
    WHERE address1 LIKE '%CONFIDENTIAL%'
  )"
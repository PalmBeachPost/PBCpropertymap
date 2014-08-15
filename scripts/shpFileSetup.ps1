param(
    $u ='postgres',
    $p = 5432,
    $db = 'propertydb'
)

#shape file we are going to keep only the latest one
$exists = test-path '../parcelshape/parcels.sql'
if(!$exists){
  cd '../parcelshape'  
  shp2pgsql.exe -I -d -s 2236 Parcels parcels > parcels.sql
  cd '../scripts'
}
PSQL -U $u -h localhost -p $p -w -d $db -f ../parcelshape/parcels.sql

$exists = test-path '../parcelshape/condos.sql'
if(!$exists){
  cd '../parcelshape'  
  shp2pgsql.exe -W "LATIN1" -n .\condodata.dbf > condos.sql
  cd '../scripts'
}
PSQL -U $u -h localhost -p $p -w -d $db -f ../parcelshape/condos.sql
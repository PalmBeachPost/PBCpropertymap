param(
    $u ='postgres',
    $p = 5432,
    $db = 'propertydb'
)

#shape file we are going to keep only the latest one
$exists = test-path '../parcelshape/parcels.sql'
if(!$exists){
  cd '../parcelshape'  
  shp2pgsql.exe -I -s 2236 Parcel_2014 parcel > parcels.sql
  cd '../scripts'
}
#PSQL -U $u -h localhost -p $p -w -d $db -f ../parcelshape/parcels.sql

$exists = test-path '../parcelshape/condos.sql'
if(!$exists){
  cd '../parcelshape'  
  shp2pgsql.exe -I -s 2236 condo_2014 condos > condos.sql
  cd '../scripts'
}
PSQL -U $u -h localhost -p $p -w -d $db -f ../parcelshape/condos.sql

PSQL -U $u -h localhost -p $p -w -d $db -f ../sql/mergeshapes.sql
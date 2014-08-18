param(
    $u ='postgres',
    $p = 5432,
    $db = 'propertydb',
    $nuke = 0
)

if($nuke -eq 1){   
    PSQL -U $u -h localhost -p $p -w -d $db -f ./sql/createrollup_12.sql
    PSQL -U $u -h localhost -p $p -w -d $db -f ./sql/createrollup_13.sql
    PSQL -U $u -h localhost -p $p -w -d $db -f ./sql/createrollup_14.sql
}

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# ADD A LINE here
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

#PSQL -U $u -h localhost -p $p -w -d $db -f ./sql/createrollup_14.sql

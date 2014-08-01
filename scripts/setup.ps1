param(
    $u ='postgres',
    $p = 5432,
    $db = 'propertydb',
    $convert = 1,
    $nuke = 0
    )

# this is the file to write the progress status to
del status.txt
new-item status.txt -type file

# Nuke db and start from scratch if specified
if ($nuke -eq 1)
{ 
    # Fresh start, create the database
    Add-content status.txt "$(Get-Date -f o) : Creating database $db"
    PSQL -U $u -h localhost -p $p -w -c "drop database if exists $db"
    CREATEDB -U $u $db
    PSQL -U $u -h localhost -p $p -w -c "CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public"
    PSQL -U $u -h localhost -p $p -w -c "CREATE SCHEMA topology AUTHORIZATION $u"
    PSQL -U $u -h localhost -p $p -w -c "CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology"

    #create all lookup tables here
    PSQL -U $u -h localhost -p $p -w -d $db -f ./sql/createCommonTables.sql
    ./import-commondata.ps1 -u $u -p $p -db $db

    # create tables per year. Add as required
    Add-content status.txt "$(Get-Date -f o) : Creating tables"
    PSQL -U $u -h localhost -p $p -w -d $db -f ./sql/createTables_12.sql
    PSQL -U $u -h localhost -p $p -w -d $db -f ./sql/createTables_13.sql    
}

#----------------------------IMPORTANT------------------------------------
# If more years are being added, FIRST add it here.
# Not inside the nuke context
# Once the file has been imported, move it into the nuke context to make sure 
# that the table does not get messed up, each time this script is run
#-------------------------------------------------------------------------


# import all the files specified in the filelist.csv into the database[BUG #51]
./import-year.ps1 -u $u -p $p -db $db -file filelist.csv

PSQL -U $u -h localhost -p $p -w -d $db -f ./sql/importdata_13.sql
PSQL -U $u -h localhost -p $p -w -d $db -f ./sql/importdata_12.sql


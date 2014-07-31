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
    # Fesh start, create the database
    Add-content status.txt "$(Get-Date -f o) : Creating database $db"
    PSQL -U $u -h localhost -p $p -w -c "drop database if exists $db"
    CREATEDB -U $u $db

     # create tables
    Add-content status.txt "$(Get-Date -f o) : Creating tables"
    PSQL -U $u -h localhost -p $p -w -d $db -f ./sql/createTables_12.sql
    PSQL -U $u -h localhost -p $p -w -d $db -f ./sql/createTables_13.sql
   
}

./import-year.ps1 -u $u -p $p -db $db -file filelist.csv


 
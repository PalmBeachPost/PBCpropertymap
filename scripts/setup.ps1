param(
    $u ='postgres',
    $p = 5432,
    $db = 'propertydb',
    $nuke = 0
    )

# convert all the fixedwidths to CSVs first
.\Convert-fixedwidth-to-csv.ps1 -fwfile '..\valuedata\REC10_TRIM2013\*.TXT' -formatfile '.\formatfiles\REC10.csv'
.\Convert-fixedwidth-to-csv.ps1 -fwfile '..\valuedata\REC20_TRIM2013\*.TXT' -formatfile '.\formatfiles\REC20.csv'
.\Convert-fixedwidth-to-csv.ps1 -fwfile '..\valuedata\REC35_TRIM2013\*.TXT' -formatfile '.\formatfiles\REC35.csv'
.\Convert-fixedwidth-to-csv.ps1 -fwfile '..\valuedata\REC36_TRIM2013\*.TXT' -formatfile '.\formatfiles\REC36.csv'
.\Convert-fixedwidth-to-csv.ps1 -fwfile '..\valuedata\REC40_TRIM2013\*.TXT' -formatfile '.\formatfiles\REC40.csv'

# Nuke db and start from scratch if specified
if ($nuke -eq 1)
{
    # create tables
    PSQL -U $u -h localhost -p $p -w -d $db -f ./sql/createTables.sql
    
    # this is the file to write the progress status to
    del status.txt
    new-item status.txt -type file
}

# Chris TODO: Now add script to import these files. Avoid hardcoding anywhere else except this one file
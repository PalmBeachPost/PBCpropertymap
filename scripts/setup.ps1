param(
    $u ='postgres',
    $p = 5432,
    $db = 'propertydb',
    $nuke = 0
    )

# convert all the fixedwidths to CSVs first
.\Convert-fixedwidth-to-csv.ps1 -fwfile '..\valuedata\2013\REC10_CERT2013.TXT' -formatfile '.\formatfiles\REC10.csv'
.\Convert-fixedwidth-to-csv.ps1 -fwfile '..\valuedata\2013\REC20_CERT2013.TXT' -formatfile '.\formatfiles\REC20.csv'
.\Convert-fixedwidth-to-csv.ps1 -fwfile '..\valuedata\2013\REC35_CERT2013.TXT' -formatfile '.\formatfiles\REC35.csv'
.\Convert-fixedwidth-to-csv.ps1 -fwfile '..\valuedata\2013\REC36_COPY.TXT' -formatfile '.\formatfiles\REC36.csv'
.\Convert-fixedwidth-to-csv.ps1 -fwfile '..\valuedata\2013\REC40_CERT2013.TXT' -formatfile '.\formatfiles\REC40.csv'
.\Convert-fixedwidth-to-csv.ps1 -fwfile '..\valuedata\2012\REC10_TRIM2012.TXT' -formatfile '.\formatfiles\REC10.csv'
.\Convert-fixedwidth-to-csv.ps1 -fwfile '..\valuedata\2012\REC20_TRIM2012.TXT' -formatfile '.\formatfiles\REC20.csv'
.\Convert-fixedwidth-to-csv.ps1 -fwfile '..\valuedata\2012\REC35_TRIM2012.TXT' -formatfile '.\formatfiles\REC35.csv'
.\Convert-fixedwidth-to-csv.ps1 -fwfile '..\valuedata\2012\REC36_COPY.TXT' -formatfile '.\formatfiles\REC36.csv'
.\Convert-fixedwidth-to-csv.ps1 -fwfile '..\valuedata\2012\REC40_TRIM2012.TXT' -formatfile '.\formatfiles\REC40.csv'

# Nuke db and start from scratch if specified
if ($nuke -eq 1)
{
    # Fesh start, create the database
    PSQL -U $u -h localhost -p $p -w -c "drop database if exists $db"
    CREATEDB -U $u $db

    # create tables
    PSQL -U $u -h localhost -p $p -w -d $db -f ./sql/createTables.sql
    
    # this is the file to write the progress status to
    del status.txt
    new-item status.txt -type file
}

# Chris TODO: Now add script to import these files. Avoid hardcoding anywhere else except this one file
PSQL -U $u -h localhost -p $p -w -d $db -c "COPY raw13Rec10 FROM '..\valuedata\2013\REC10_CERT2013.CSV' DELIMITER ','"
PSQL -U $u -h localhost -p $p -w -d $db -c "COPY raw13Rec20 FROM '..\valuedata\2013\REC20_CERT2013.CSV' DELIMITER ','"
PSQL -U $u -h localhost -p $p -w -d $db -c "COPY raw13Rec35 FROM '..\valuedata\2013\REC35_CERT2013.CSV' DELIMITER ','"
PSQL -U $u -h localhost -p $p -w -d $db -c "COPY raw13Rec36 FROM '..\valuedata\2013\REC36_COPY.CSV' DELIMITER ','"
PSQL -U $u -h localhost -p $p -w -d $db -c "COPY raw13Rec40 FROM '..\valuedata\2013\REC40_CERT2013.CSV' DELIMITER ','"
PSQL -U $u -h localhost -p $p -w -d $db -c "COPY raw12Rec10 FROM '..\valuedata\2012\REC10_TRIM2012.CSV' DELIMITER ','"
PSQL -U $u -h localhost -p $p -w -d $db -c "COPY raw12Rec20 FROM '..\valuedata\2012\REC20_TRIM2012.CSV' DELIMITER ','"
PSQL -U $u -h localhost -p $p -w -d $db -c "COPY raw12Rec35 FROM '..\valuedata\2012\REC35_TRIM2012.CSV' DELIMITER ','"
PSQL -U $u -h localhost -p $p -w -d $db -c "COPY raw12Rec36 FROM '..\valuedata\2012\REC36_COPY.CSV' DELIMITER ','"
PSQL -U $u -h localhost -p $p -w -d $db -c "COPY raw12Rec40 FROM '..\valuedata\2012\REC40_TRIM2012.CSV' DELIMITER ','"
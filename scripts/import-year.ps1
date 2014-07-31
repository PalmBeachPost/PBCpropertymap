param(
    $u ='postgres',
    $p = 5432,
    $db = 'propertydb',
    $file
)

$filelist = import-csv $file
$filelist | foreach {
    if($convert -eq 1){
        Add-content status.txt "$(Get-Date -f o) : Starting conversion of $_.outfile"
        ./convert-fw-to-csv.ps1 -inputFile $_.infile -outputfile $_.outfile -fileformat $_.format
        Add-content status.txt "$(Get-Date -f o) : Completed conversion"
    }
    $table = $_.table
    $outfile = $_.outfile
    $command = "COPY $table FROM '$outfile' DELIMITER ','"
    Add-content status.txt "$(Get-Date -f o) : Running $command"
    PSQL -U $u -h localhost -p $p -d $db -w -c $command
    Add-content status.txt "$(Get-Date -f o) : imported data to $table"
}

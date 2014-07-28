param(
	$fwfile = '.\RECTestdata.txt',
	$formatfile = '.\recformat.csv',
    $outFile
)
$fwfile = resolve-path $fwfile
$formatfile = resolve-path $formatfile

$fields = import-csv $formatfile
$fields.width|%{ $widths+= $_+','}
$widths = $widths.trim(',')

$names =''
$fields.field | foreach { $names += $_+','}
if($outFile -eq $null){
    $outFile = $fwfile.path.replace($fwfile.path.substring($fwfile.path.lastindexof('.')),".csv")
}
$names.trim(',')|out-file $outFile

$reader = [System.IO.File]::OpenText($fwfile)
try {
    $line = $reader.ReadLine()
    while($line -ne $null) {
        $lineCsv= ''
        $pos= 0
        $fields|where {$_ -ne $null}|
         foreach-object {           
           $lineCsv +=  $line.Substring($pos,$_.width).Trim()+','
           $pos+=$_.width         
        }
        $line = $reader.ReadLine()
        $lineCsv = $lineCsv.Trim(',')| out-file $outFile -Append
    }
}
finally {
    $reader.Close()
}
param(
    $inputFile ="C:\git\propertymap\valuedata\test10.txt",
    $outputFile="C:\git\propertymap\valuedata\test10.csv",
    $fileformat = 10
)
$xlFixedWidth = 2
$xlTextFormat = 2
$xlCSV=6

$inputFile = (Resolve-path $inputFile).Path

#TODO make this array a parameter, then the script can be generic
$rec10format =  (
    (1,$xlTextFormat),
    (18,$xlTextFormat),
    (20,$xlTextFormat),
    (24,$xlTextFormat),
    (54,$xlTextFormat),
    (124,$xlTextFormat),
    (194,$xlTextFormat),
    (264,$xlTextFormat),
    (273,$xlTextFormat),
    (316,$xlTextFormat),
    (359,$xlTextFormat),
    (402,$xlTextFormat),
    (445,$xlTextFormat),
    (448,$xlTextFormat)
)

$rec35format = (
    (1,$xlTextFormat),
    (18,$xlTextFormat),
    (20,$xlTextFormat),
    (21,$xlTextFormat),
    (28,$xlTextFormat),
    (39,$xlTextFormat),
    (40,$xlTextFormat),
    (47,$xlTextFormat),
    (58,$xlTextFormat),
    (59,$xlTextFormat),
    (66,$xlTextFormat),
    (77,$xlTextFormat),
    (78,$xlTextFormat),
    (85,$xlTextFormat),
    (96,$xlTextFormat),
    (97,$xlTextFormat),
    (104,$xlTextFormat),
    (115,$xlTextFormat),
    (116,$xlTextFormat),
    (123,$xlTextFormat),
    (134,$xlTextFormat),
    (135,$xlTextFormat),
    (142,$xlTextFormat),
    (153,$xlTextFormat),
    (154,$xlTextFormat),
    (161,$xlTextFormat),
    (172,$xlTextFormat),
    (173,$xlTextFormat),
    (180,$xlTextFormat),
    (191,$xlTextFormat),
    (192,$xlTextFormat),
    (199,$xlTextFormat),
    (210,$xlTextFormat),
    (211,$xlTextFormat),
    (218,$xlTextFormat),
    (229,$xlTextFormat),
    (230,$xlTextFormat),
    (237,$xlTextFormat),
    (248,$xlTextFormat),
    (249,$xlTextFormat),
    (256,$xlTextFormat),
    (267,$xlTextFormat),
    (268,$xlTextFormat),
    (275,$xlTextFormat),
    (286,$xlTextFormat),
    (287,$xlTextFormat),
    (294,$xlTextFormat),
    (305,$xlTextFormat),
    (306,$xlTextFormat),
    (313,$xlTextFormat),
    (324,$xlTextFormat),
    (325,$xlTextFormat),
    (332,$xlTextFormat),
    (343,$xlTextFormat),
    (344,$xlTextFormat),
    (351,$xlTextFormat),
    (362,$xlTextFormat),
    (363,$xlTextFormat),
    (370,$xlTextFormat),
    (381,$xlTextFormat),
    (382,$xlTextFormat),
    (389,$xlTextFormat),
    (400,$xlTextFormat),
    (401,$xlTextFormat),
    (408,$xlTextFormat),
    (419,$xlTextFormat),
    (420,$xlTextFormat),
    (427,$xlTextFormat),
    (438,$xlTextFormat),
    (439,$xlTextFormat),
    (446,$xlTextFormat),
    (457,$xlTextFormat),
    (458,$xlTextFormat),
    (465,$xlTextFormat),
    (476,$xlTextFormat),
    (477,$xlTextFormat)
)

$rec36format = $rec35format

$rec40format = (
    (1,$xlTextFormat),
    (18,$xlTextFormat),
    (20,$xlTextFormat),
    (25,$xlTextFormat),
    (29,$xlTextFormat),
    (32,$xlTextFormat),
    (44,$xlTextFormat),
    (56,$xlTextFormat),
    (60,$xlTextFormat),
    (72,$xlTextFormat),
    (84,$xlTextFormat),
    (96,$xlTextFormat),
    (108,$xlTextFormat),
    (120,$xlTextFormat),
    (132,$xlTextFormat),
    (144,$xlTextFormat),
    (156,$xlTextFormat),
    (168,$xlTextFormat),
    (180,$xlTextFormat),
    (192,$xlTextFormat),
    (204,$xlTextFormat),
    (216,$xlTextFormat),
    (228,$xlTextFormat),
    (240,$xlTextFormat),
    (252,$xlTextFormat),
    (264,$xlTextFormat),
    (276,$xlTextFormat),
    (286,$xlTextFormat),
    (296,$xlTextFormat)
)

# Pick the right format array
switch ($fileformat){
    10 {$recformat = $rec10format; break}
    20 {$recformat = $rec20format; break}
    35 {$recformat = $rec35format; break}
    36 {$recformat = $rec36format; break}
    40 {$recformat = $rec40format; break}
    default {break}
}

$Excel = New-Object -comobject Excel.Application
$Excel.Visible = $false
$Excel.displayalerts = $False
$Workbook = $Excel.Workbooks.OpenText($inputFile,2,1,$xlFixedWidth,-4142,$false,$false,$false,$false,$false,$false,$false,$recformat)
$Excel.ActiveSheet.UsedRange.Replace(",","-")
$Excel.ActiveWorkbook.saveas($outputFile,$xlCSV)
$Excel.Quit()

# Sometimes excel won't quit. Kill it!!!! Mercilessly.
If(ps excel){
     kill -name excel
}

# Reopen and save with correct encoding to make sure it is UTF8 without BOM
(get-content -path $outputFile)|
    out-file $outputFile -encoding utf8  
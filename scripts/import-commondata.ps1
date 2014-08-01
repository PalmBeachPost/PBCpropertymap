param(
    $u ='postgres',
    $p = 5432,
    $db = 'propertydb'
)

$proplookupfile = Resolve-path '.\data\propUseCode.tsv'
$proplookupfile = $proplookupfile.path
PSQL -U $u -h localhost -p $p -w -d $db -c "copy propUseLookup from '$proplookupfile'"
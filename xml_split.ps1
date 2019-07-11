#initialize parameters
$xml_path = "D:\Johnson\Project\maxkuan\Johnson\xml_split\ipg190521.xml"
$target_patent = "D0848707"
$output_file_path = "D:\Johnson\Project\maxkuan\Johnson\xml_split\result.xml"
$split_element = "(?s)</us-patent-grant>"
#get xml file.
$xml = gc -path $xml_path
#split the target patent
$split = [regex]::Split($xml, $split_element) | Select-String $target_patent
#output result
$split.ToString() + $split_element | Out-File -FilePath $output_file_path
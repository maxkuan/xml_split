#initialize parameters
$xml_path = "./sample.xml"
$target_patent = "D0848707"
$output_file_path = "./result.xml"
$end_element = "</us-patent-grant>"

<#
$split_element = "</us-patent-grant>"

#get xml file.
$xml = gc -path $xml_path
#split the target patent
$split = [regex]::Split($xml, $split_element) | Select-String $target_patent
#output result
$split.ToString() + $split_element | Out-File -FilePath $output_file_path
#>

$stream_reader = New-Object System.IO.StreamReader($xml_path)
$output_content = $stream_reader.ReadLine() + "`n"
$output_content = $output_content + $stream_reader.ReadLine() + "`n"

while (($eachline = $stream_reader.ReadLine()) -ne $null) {
	if ($eachline.contains($target_patent)) {
		$output_content = $output_content + $eachline + "`n"
		
		while (($content = $stream_reader.ReadLine()) -ne $null) {
			$output_content = $output_content + $content + "`n"
			
			if ($content.contains($end_element)) {
				$output_content | Out-File -FilePath $output_file_path
				break
			}
		}
		break
	}
}
$stream_reader.Dispose()


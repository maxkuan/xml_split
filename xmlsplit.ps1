param (
    [Parameter(Mandatory=$true)][string]$filename,
    [string]$output
)
#initialize parameters
$end_element = "</us-patent-grant>"
$start='^<us-patent-grant'
$end='^</us-patent-grant>$'
$pub = "^<publication-reference>$"
$doc = "^<doc-number>"

$patent_count = 0
$output_content = ""
$write_flag = 0
$pub_flag = 0
$patent_no = ""
$stream_reader = New-Object System.IO.StreamReader($filename)

if($output) {
    if(-not (Test-Path -Path $output)) {
        New-Item -ItemType directory -Path $output
    }
}

while (($eachline = $stream_reader.ReadLine()) -ne $null) {
	if ($eachline -match $start) {
		# Write-Output $count $eachline
        $patent_count += 1
        $write_flag = 1
	}
    if($output) {
        if ($eachline -match $pub) {
            $pub_flag = 1
        }

        if ($eachline -match $doc -and $pub_flag) {
            $t = $eachline.Replace('<doc-number>', '')
            $patent_no = $t.Replace('</doc-number>', '')
            $pub_flag = 0
        }

        if($write_flag) {
            $output_content += $eachline +"`n"
        }
        if ($eachline -match $end) {
            $write_flag = 0
            $output_content | Out-File -FilePath "./$($output)/$($patent_no).xml"
            $output_content = ""
            
        }
    }
    
}
$stream_reader.Dispose()

Write-Output "Patent in this xml: $($patent_count)"


# for ($i=0; $i -lt $result_arr.length; $i+=2) {
# 	$o = (Get-Content -Path $xml_path | Select -range 3)
#     Write-Output $o
# }
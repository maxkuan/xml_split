param (
    [Parameter(Mandatory=$true)][string]$filename,
    [string]$search
)
#initialize parameters
$start='^<us-patent-grant'
$end='^</us-patent-grant>$'
$doc = "^<doc-number>"
$target_doc = "^<doc-number>$search</doc-number>$"
Write-Output $target_doc
$output_content = ""
$write_flag = 0

$stream_reader = New-Object System.IO.StreamReader($filename)
while (($eachline = $stream_reader.ReadLine()) -ne $null) {
	if ($eachline -match $start) {
		# Write-Output $count $eachline
        $write_flag = 1
	}
    if($eachline -match $doc) {
        if(!$eachline -match $target_doc) {
            $write_flag = 0
        }
    }
    if($write_flag) {
        $output_content += $eachline +"`n"
    }
    if ($eachline -match $end -and $write_flag) { 
        $output_content | Out-File -FilePath "./$($search).xml"
        break 
    }
    
}
$stream_reader.Dispose()

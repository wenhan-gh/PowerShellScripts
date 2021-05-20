$a = Get-ChildItem G:\PHOTO\TOBESORTED
$dest = 'G:\PHOTO\From-Whatsapp'
$a | ForEach-Object{ $file = $_.name;$full = $_.fullname
switch -wildcard ($file) {
 "IMG*" {Write-Host $file
 [string]$date = ($file.split("-"))[1]
 $date
 $datetime = [datetime]::ParseExact($date,"yyyyMMdd",$null)
 $datetime
 $year = $datetime.Year
 $month = $datetime.ToString("MM")
 $Directory = $dest + "\" + $year + "-" + $month + "\"
 $Directory
 if (!(Test-Path $Directory)) {New-Item $Directory -type directory}}

}#ENDSWITCH

Move-Item $full $Directory

}#ENDFOREACH
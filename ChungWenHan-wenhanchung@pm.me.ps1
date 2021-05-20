#REQUIRES -Version 5.0
<#
.Description
    Script by Chung Wen Han for "System Engineer (SE) - Work Sample Test 2021 - First Attempt
.LINK
    Copy of script also available on my github at:
    https://github.com/wenhan-gh/PowerShellScripts
#>

function listChildFolder($folderPath) {
    <#
    .Description
    Lists items from given folder path.
    #>

    try {
        If ( (Get-ChildItem $folderPath -ErrorAction Stop | Measure-Object).count -eq 0 )
            {
                Write-Output "Folder is empty."
            }
        else
            {
                $folderContent = Get-ChildItem $folderPath -ErrorAction Stop | Sort-Object LastWriteTime
                [array]$listofNames = $folderContent | ForEach-Object {$_.Name}
                [string]$result = $null
                $result = '"{0}"' -f ($listofNames -join '","')
                return $result
            }
    }
    catch [System.IO.DirectoryNotFoundException],[System.IO.FileNotFoundException],[System.Management.Automation.ItemNotFoundException] {
        # Catch not found exceptions.
        throw "ERROR: Cannot locate path: [ $folderPath ]."
    }
    catch [System.IO.IOException] {
        # Catch if there are any IO errors.
        throw "ERROR: IO error with path: [ $folderPath ]."
    }
}

function compareTwoFiles([String]$firstFilePath, [String]$secondFilePath) {
    <#
    .Description
    Compares the sizes of two files and returns which is largers.
    #>

    #Write-Host ("1st file size is: " + $1stFile.Length/1KB + " kilobytes")
    #Write-Host ("2nd file size is: " + $2ndFile.Length/1KB + " kilobytes")

    # Check files first.
    try {
        $1stFile = Get-ChildItem $firstFilePath -ErrorAction Stop
    }
    catch [System.IO.FileNotFoundException],[System.Management.Automation.ItemNotFoundException] {
        throw "ERROR: First given file not found."
    }
    try {
        $2ndFile = Get-ChildItem $secondFilePath -ErrorAction Stop   
    }
    catch [System.IO.FileNotFoundException],[System.Management.Automation.ItemNotFoundException] {
        throw "ERROR: Second given file not found."
    }

    # Can now continue after checks.
    if ($1stFile.Length -eq $2ndFile.Length) {
        Write-Host ("Both files have the same size.")
    }
    elseif ($1stFile.Length -gt $2ndFile.Length) {
        #Write-Host ("File [ " + $1stFile.Name + " ] is larger than file [ " + $2ndFile.Name + " ].")
        Write-Host ("File [ " + $1stFile.Name + " ] is larger.")
    }
    elseif ($1stFile.Length -lt $2ndFile.Length) {
        #Write-Host ("File [ " + $2ndFile.Name + " ] is larger than file [ " + $1stFile.Name + " ].")
        Write-Host ("File [ " + $2ndFile.Name + " ] is larger.")
    }
}

# For verifying, feel free to edit and use them.
# listChildFolder "C:\DoesNotExist" #Folder that does not exist.
# compareTwoFiles "C:\Users\chngw\Powershell\ChungWenHan-wenhanchung@pm.me.ps1" "C:\invalidFolder\invalidFile2"
# compareTwoFiles "C:\invalidFolder\invalidFile1" "C:\Users\chngw\Powershell\ChungWenHan-wenhanchung@pm.me.ps1"

# $username = [System.Environment]::UserName
# listChildFolder "C:\Users\$username\Documents"

# compareTwoFiles "C:\Users\chngw\Powershell\ChungWenHan-wenhanchung@pm.me.ps1" "C:\Users\chngw\Powershell\MovePhotos.ps1"
# compareTwoFiles "C:\Users\chngw\Powershell\MovePhotos.ps1" "C:\Users\chngw\Powershell\ChungWenHan-wenhanchung@pm.me.ps1"

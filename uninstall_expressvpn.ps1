$startingdirectory = pwd

#checks for existance of the app
$appconfirm = (get-package "ExpressVPN" -ErrorAction SilentlyContinue)
if(!$appconfirm){
    write-host "Express VPN not installed. Exiting"
    exit 0
}else{
    write-host "Express VPN Installed. Attempting to Uninstall"
}

$path = "C:\ProgramData\Package Cache"
$folderlist = Get-ChildItem -Path $path -ErrorAction SilentlyContinue

#find and execute the uninstall string
foreach($folder in $folderlist){
    $filelist = Get-ChildItem $path\$folder -ErrorAction SilentlyContinue
        foreach($file in $filelist){
            if($file -like "*ExpressVPN*" -and $file -like "*.exe*"){
            write-host "Uninstall file found at path $path\$folder\$file"
            write-host "Attempting to uninstall"
            $uninstallkey = $true
            cd $path\$folder
            cmd /c "$file /uninstall /quiet"
            cd $startingdirectory
        }
    }
}

#confirms that an uninstall string was found
if(!$uninstallkey){
    write-host "Script Error. Exiting"
    Exit 1
}

#confirms uninstallation 
$counter = 1
while($counter -le 10){
    Start-Sleep 15
    $appconfirm = (get-package "ExpressVPN" -ErrorAction SilentlyContinue)
        if($appconfirm){
            $counter = $counter + 1
        }else{
            break
        }
}
$appconfirm = (get-package "ExpressVPN" -ErrorAction SilentlyContinue) 
if($appconfirm){
    Write-Host "Uninstall Failed or Timed Out. Exiting"
    exit 1
}else{
    write-host "Uninstall Complete"
    exit 0
}




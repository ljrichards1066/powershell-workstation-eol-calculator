##variables

#production
$cpustring = (((Get-CimInstance -ClassName 'Win32_Processor').name | out-string))
#production

#test
#$cpustring = "Intel(R) Core(TM) i5-10500T CPU @ 2.30GHz"
#test
$cpuarray = $cpustring.split()
$numbersstring = ($cpustring -replace '[^0-9]', ' ')
$numberarray = $numbersstring.split()
$ramarray = (((Get-WmiObject Win32_PhysicalMemory | Select-Object SMBIOSMemoryType).smbiosmemorytype) | Out-String).split()
$ramtype = $ramarray[0]

foreach ($_ in $numberarray){
    
    if([int]$_ -ge 1000){
        $cpugennum = $_
          
    }
}

if($cpustring -like "*Intel*"){
    echo "Intel CPU Detected"
    $intel = $true
}elseif($cpustring -like "*AMD*"){
    echo "AMD CPU Detected"
    $amd = $true
}

#override
if($cpustring -like "*FX*"){
    echo "FX CPU detected"
    $override = $true
}elseif($cpustring -like "*Athlon*"){
    echo "Athlon CPU Detected"
    $override = $true
}elseif($cpustring -like "*Sempron*"){
    echo "Sempron CPU Detected"
    $override = $true
}elseif($ramtype -le 24){
    echo "DDR3 Detected"
    $Override = $true
}

#intel oddball CPUs
if([int]$cpugennum -le 1999 -and $intel -eq $True) {
    echo "Oddball Intel CPU detected"
    $cpugennum = (([int]($cpugennum)) * 10)

}else{
    echo "Oddball Intel CPU not detected"
}


$cpugennum


#Intel Calculations
if($intel -eq $true)
    {
    
    if($cpugennum -in 2000..2999){
        $cpudate = "12/31/2011"
    }elseif($cpugennum -in 3000..3999){
        $cpudate = "12/31/2012"
    }elseif($cpugennum -in 4000..4999){
        $cpudate = "12/31/2013"    
    }elseif($cpugennum -in 5000..5999){
        $cpudate = "12/31/2014"
    }elseif($cpugennum -in 6000..6999){
        $cpudate = "12/31/2015"
    }elseif($cpugennum -in 7000..7999){
        $cpudate = "12/31/2016"
    }elseif($cpugennum -in 8000..8999){
        $cpudate = "12/31/2017"
    }elseif($cpugennum -in 9000..9999){
        $cpudate = "12/31/2018"
    }elseif($cpugennum -in 10000..10999){
        $cpudate = "12/31/2019"
    }elseif($cpugennum -in 11000..12999){
        $cpudate = "12/31/2021"
    }elseif($cpugennum -in 13000..13999){
        $cpudate = "12/31/2022"
    }elseif($cpugennum -in 14000..14999){
        $cpudate = "12/31/2023"
    }elseif($cpugennum -in 15000..15999){
        $cpudate = "12/31/2024"
    }elseif($cpugennum -in 16000..16999){
        $cpudate = "12/31/2025"
    }else{
         $unknown = $true
         echo "CPU Age Unkown"
    }
}
else{}

#AMD Ryzen Calculations
if($AMD -eq $true)
    {

    if($cpugennum -in 1000..1999){
        $cpudate = "12/31/2017"
    }elseif($cpugennum -in 2000..2999){
        $cpudate = "12/31/2018"
    }elseif($cpugennum -in 3000..3999){
        $cpudate = "12/31/2019"
    }elseif($cpugennum -in 4000..4999){
        $cpudate = "12/31/2020"
    }elseif($cpugennum -in 5000..5999){
        $cpudate = "12/31/2021"
    }elseif($cpugennum -in 6000..6999){
            $cpudate = "12/31/2022"
    }elseif($cpugennum -in 7000..7999){
        $cpudate = "12/31/2023"
    }elseif($cpugennum -in 8000..8999){
        $cpudate = "12/31/2024"
    }elseif($cpugennum -in 9000..9999){
        $cpudate = "12/31/2025"
    }else{
         $unknown = $true
         echo "CPU Age Unkown"
    }
}
else{}

#translate date
if($unknown -ne $true){
    $cpudate = $cpudate | Get-Date
    if($cpudate.Year -ge (get-date).Year){
        $current = $True
    }
    else{
        $difference = new-timespan -start $cpudate -end (get-date)
    }
}
$difference
$unknown
#return boolean variable to Datto

if($override -eq $True){
    #insert RMM specific command
    Echo "True"
}
elseif($unknown -eq $true){
    #insert RMM specific command
    echo "CPU Age Unknown"
}
elseif ($difference.Days -gt 1095) {
    #insert RMM specific command    
    echo "CPU Generation over 3 years old: True"
}
elseif ($difference.Days -le 1095 ){
    #insert RMM specific command
    echo "CPU Generation over 3 years old: False"
}







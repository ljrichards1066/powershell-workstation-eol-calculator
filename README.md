powershell-workstation-eol-calculator

# CPU Gen Over 3 Years.ps1
This script is intended to assist with tracking the age of workstations in your environment to aid in planning and budgeting. It is expected that this would be paired with an RMM solution, and the specifics of how this result would be written to the device's entry in that RMM will vary. These RMM specifics should be added under each of the If/Else if statements at the end.
It will count a a CPU generation date as the final day of the year that it was released. 
The script will determine the generation of the CPU by getting the CPU info and taking to model number (eg a number in the 11000s for a 11th gen Intel) and compare it to the year that generation came out. 
the script will differentiate between Intel and AMD, and has a few overrides in place for obvious red flags of a CPU/Computer who's CPU generation is over 3 years old. 
To use the testing function, comment out the "production" section and uncomment the "testing" section. Input an expected return of the command in the production section for the computer in question you would be fake testing on. 

I intend to cleanup the code in the future. I also intend to remove the bash language in future versions. 



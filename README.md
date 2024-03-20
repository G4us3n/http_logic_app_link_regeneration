# Link regeneration powershell script
This script makes it easy to generate the links of multiple Logic Apps that have an HTTP trigger with the same trigger's name present in the same Resource Group using either the primary or secondary key of the Logic Apps.
## How to use
To use the script, it is necessary to create a file "inputFile.txt" in the root directory. The input file will be read and the script will take the resource group of the Logic Apps from the first line of the file, from the second line the key with which to generate the links will be chosen (if the second line is "primary" the links will be generated with the primary key, otherwise the secondary key will be used) and the remaining lines are reserved for the names of the Logic Apps whose links are to be regenerated.
The generated links will be saved in the file "outputLinks.txt" that will be created in the root directory.
>The HTTP trigger name of the Logic Apps is specified in line 22 of the script.
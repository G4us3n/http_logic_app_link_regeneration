# Percorso del file di input fornito dall'utente
$inputFilePath = ".\inputFile.txt"
# Percorso del file di output dove verranno salvati i link
$outputFilePath = ".\outputLinks.txt"

# Leggere il contenuto del file di input
$content = Get-Content $inputFilePath

# Estrazione delle informazioni dal file di input
$resourceGroupName = $content[0]
$keyType = $content[1]
$logicAppNames = $content[2..$content.Length]

# Autenticazione in Azure (se non già autenticato)
# Connect-AzAccount

# Inizializzazione dell'array per i link generati
$generatedLinks = @()

foreach ($appName in $logicAppNames) {
    # Ottenere i dettagli del trigger HTTP della Logic App
    $trigger = Get-AzLogicAppTrigger -ResourceGroupName $resourceGroupName -Name $appName -TriggerName "manual"
    
    # Ottenere le chiavi di accesso della Logic App
    $keys = Get-AzLogicAppAccessKey -ResourceGroupName $resourceGroupName -Name $appName

    # Selezionare la chiave in base all'input
    $keyToUse = $keyType -eq "primary" ? $keys.PrimaryKey : $keys.SecondaryKey

    # Costruire il link del trigger HTTP
    $callbackUrl = $trigger.Properties.endpoint + "?sig=" + $keyToUse

    # Aggiungere il link generato all'array
    $generatedLinks += $callbackUrl
}

# Scrivere i link generati nel file di output
$generatedLinks | Out-File $outputFilePath

# Stampa di conferma
Write-Output "I link delle Logic App sono stati generati e salvati in: $outputFilePath"
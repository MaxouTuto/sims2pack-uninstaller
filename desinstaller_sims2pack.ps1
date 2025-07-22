
$installPath = "C:\Program Files (x86)\Sims2Pack Clean Installer"


$appName = "Sims2Pack Clean Installer"


$uninstallKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
$uninstallKeyWow = "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

Get-ChildItem $uninstallKey, $uninstallKeyWow | ForEach-Object {
    $displayName = $_.GetValue("DisplayName") 
    if ($displayName -like "*$appName*") {
        Write-Host "Suppression de la clé de désinstallation : $displayName"
        Remove-Item $_.PSPath -Recurse -Force
    }
}


if (Test-Path $installPath) {
    Write-Host "Suppression du dossier : $installPath"
    Remove-Item $installPath -Recurse -Force
} else {
    Write-Host "Le dossier d'installation n'existe pas."
}


$regKeys = @(
    "HKCU:\Software\Sims2Pack Clean Installer",
    "HKLM:\Software\Sims2Pack Clean Installer",
    "HKLM:\Software\WOW6432Node\Sims2Pack Clean Installer"
)

foreach ($key in $regKeys) {
    if (Test-Path $key) {
        Write-Host "Nettoyage du registre : $key"
        Remove-Item $key -Recurse -Force
    }
}

Write-Host "Désinstallation terminée !"

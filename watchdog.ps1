


# Chemin de l'exécutable de Plex Media Server
$plexPath = 'C:\Program Files\Plex\Plex Media Server\Plex Media Server.exe'

# Fichier log sur le bureau
$logFile = "C:\Users\maxim\OneDrive\Documents\plex_scripts\watchdog\PlexServiceLog.txt"

# URL du service Plex
$plexUrl = 'http://127.0.0.1:32400/'

    # Vérification de la présence du processus Plex
    $plexProcess = Get-Process 'Plex Media Server' -ErrorAction SilentlyContinue

    if(-not $plexProcess)
    {
        # Si Plex n'est pas en cours d'exécution, démarrer le processus
        Start-Process -FilePath $plexPath -WindowStyle Minimized
        $logMessage = "$(Get-Date): Plex Media Server démarré car le processus était introuvable."
        Add-Content $logFile -Value $logMessage
        Write-Host $logMessage
    }
    else
    {
        $plexIsRunning = $false
        try
        {
            # Si Plex est en cours d'exécution, vérifier l'accessibilité de l'URL du service
            $response = Invoke-WebRequest -Uri $plexUrl -TimeoutSec 5 -ErrorAction Stop
            #$plexIsRunning = $true
        }
        catch [System.Net.WebException]
        {
            if ($_.Exception.Response.StatusCode -eq 401)
            {
                $plexIsRunning = $true
            }
        }
        catch
        {
            $plexIsRunning = $false
        }

        if (-not $plexIsRunning)
        {
            Stop-Process -Name 'Plex Media Server' -Force
            Start-Process -FilePath $plexPath -WindowStyle Minimized
            $logMessage = "$(Get-Date): Plex Media Server redémarré car le site web n'était pas accessible."
            Add-Content $logFile -Value $logMessage
            Write-Host $logMessage
        }
    }




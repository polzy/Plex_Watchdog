# Plex_Watchdog

### Plex Media Server Watchdog Script
This script checks the status of the Plex Media Server (PMS) and restarts it if needed. It also logs the actions to a designated file.

### Features:
Process Check: Verifies if the PMS process is running on the machine.
Service Health Check: If the PMS process is running, it checks the service's health by accessing its URL.
Auto-restart: Restarts PMS if the process is not found or if the service URL is not accessible.
Logging: Logs the actions performed by the script, such as starting or restarting the PMS.
### Configuration:
Set the path to the PMS executable in $plexPath.
Designate the location of the log file in $logFile.
Configure the PMS service URL in $plexUrl.
### Usage:
Run the script regularly, or as a scheduled task, to ensure the health and availability of Plex Media Server.

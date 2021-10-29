@echo off
chcp 65001

set /p rootpass="Root-Passwort festlegen: "
set /p setupNewDB="Neue Datenbank und Benutzer anlegen? [N für Nein, Beliebige Eingabe für Ja]: "

if %setupNewDB%==N or if %setupNewDB%==n goto SETUPROOT

set /p dbuser="Datenbank-Benutzername: "
set /p dbpass="Passwort: "
set /p dbname="Datenbank-Name: "

:SETUPROOT
ECHO Connecting to database and changing root password...&echo\
cmd /k mysql -u root --execute="ALTER USER 'root'@'localhost' IDENTIFIED BY '%rootpass%'; FLUSH PRIVILEGES;"
ECHO Done.&echo\

PAUSE

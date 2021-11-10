@echo off
chcp 65001

set /p DUMMY="Um mit der Installation fortzufahren, drücke ENTER"



echo 1) Zip wird entpackt

tar -xf mariadb-10.6.4-winx64.zip
set mariaDir=%~dp0mariadb-10.6.4-winx64
echo Zip wurde in '%mariaDir%' entpackt




echo.
echo 2) MariaDB wird zu Umgebungsvariablen hinzugefügt

REM Set home variable, so that mariadb knows where to look for files
setx MARIADB_HOME "%mariaDir%"



REM Tell windows where mariadb binaries are located, so that they can be executed (eg.: mysqld)
setx var1 ^"%PATH%;^%MARIADB_BIN^%^" /m

REM Set path variable in different env variable. This tells where the binaries are located.
setx MARIADB_BIN "%mariaDir%\bin"


echo.
echo 3) MariaDB installieren >> mysql_install_db

REM According to the docs, this is required to create all default tables needed for operation.
mysql_install_db

echo.






echo.
echo 4) MariaDB wird gestartet >> mysqld

REM This starts mariadb in different cmd window. This allows for parallel work.
start mysqld

goto END





echo.
echo 4) Hauptbenutzer einrichten
set /p rootpass="Passwort festlegen: "

echo.









echo 5) Passwort wird aktualisiert

cmd /k mysql -u root --execute="ALTER USER 'root'@'localhost' IDENTIFIED BY '%rootpass%'; FLUSH PRIVILEGES;"

choice /c yn /m "Neue Datenbank und Benutzer anlegen? [Y, N] " /n

if %ERRORLEVEL% EQU 1 goto SETUPDATABASE
if %ERRORLEVEL% EQU 2 goto END

:SETUPDATABASE
set /p dbuser="Datenbank-Benutzername: "
set /p dbpass="Passwort: "
set /p dbname="Datenbank-Name: "

goto END

:END
PAUSE

@echo off
REM Unterdrückt Nachrichten, die von einzelnen Befehlen ausgegeben werden

REM Sorgt für das Anzeigen von Sonderzeichen in der Kommandozeile
chcp 65001

REM Temporäre Umgebungsvariable (im Programmkontext), um das Zielverzeichnis festzulegen.
REM Temporär bedeutet, dass diese Variable nach beenden des Programms nicht mehr existiert und nur
REM im Zusammenhang mit diesem Prozess existiert.
set INSTALL_DIR=C:\mariadb

REM Derzeitigen Schritt in der Kommandozeile anzeigen
echo 1) Zip wird entpackt

REM Das zuvor festgelegte Zielverzeichnis erstellen
mkdir %INSTALL_DIR%

REM Das .zip-Archiv im Zielverzeichnis entpacken
REM -x  = Modus wählen (x = Extract)
REM -f  = Zu entpackendes Archiv festlegen
REM -C  = Zielverzeichnis des entpackten Archivs angeben
tar -x -f mariadb-10.6.4-winx64.zip -C %INSTALL_DIR%

REM Zielverzeichnis aktualisieren, da in diesem Verzeichnis ein 
REM weiterer Ordner angelegt wurde, worin sich die Dateien befinden
set INSTALL_DIR=%INSTALL_DIR%\mariadb-10.6.4-winx64

REM Nachricht in der Kommandozeile ausgeben, die über das Installationsverzeichnis informiert
echo Zip wurde in '%INSTALL_DIR%' entpackt



REM Leere Zeile ausgeben
echo.

REM Derzeitigen Schritt in der Kommandozeile anzeigen
echo 2) MariaDB wird zu Umgebungsvariablen hinzugefügt

REM MariaDB verlangt, dass eine Umgebungsvariable MARIADB_HOME 
REM erstellt wird, die auf das Hauptverzeichnis der Installation verweist.
REM Das zeigt MariaDB, wo Konfigurationsdateien gespeichert sind.
REM Im Gegensatz zu "set", erstellt "setx" eine Umgebungsvariable systemweit 
REM und nicht nur im Programmkontext.
setx MARIADB_HOME "%INSTALL_DIR%"
set MARIADB_BIN="%INSTALL_DIR%\bin"

REM Aktualisiert die Pfadvariable, sodass die Windows Befehlszeile informiert wird, wo mögliche ausführbare
REM Dateien liegen (sogenannte Binaries). Für MariaDB liegen diese im Zielverzeichnis unter /bin.
REM Es ist zu sehen, dass vorher der bisherige Inhalt aus PATH genommen wird und daran MARIADB_BIN angehangen wird.
REM /m = Es wird die Systemweite Pfadvariable geändert
setx PATH "%PATH%";%MARIADB_BIN% /m

REM Leere Zeile ausgeben
echo.

REM Derzeitigen Schritt in der Kommandozeile anzeigen
echo 3) MariaDB installieren >> mysql_install_db

REM Dieser Befehl ist Teil der MariaDB Binaries und kann ausgeführt werden.
REM Dadurch wird die Datenbank installiert. Das heißt, das Programm erstellt ggf.
REM weitere Standarddateien, wie Einstellungsdateien und Standarddatenbank oder auch
REM intern benötigte Daten.
%MARIADB_BIN%\mysql_install_db

REM Leere Zeile ausgeben
echo.





REM Leere Zeile ausgeben
echo.

REM Derzeitigen Schritt in der Kommandozeile anzeigen
echo 4) MariaDB wird gestartet >> mysqld

REM Der Befehl "mysqld" ist ebenfalls Teil der MariaDB Binaries und kann als Befehl
REM ausgeführt werden, um die Datenbank zu starten.
REM Damit das derzeitige Skript nicht unterbrochen wird, kann mit "start" ein neues
REM CMD-Fenster geöffnet werden, in dem dann der Befehl mysqld ausgeführt wird.
start cmd.exe /c %MARIADB_BIN%\mysqld


REM Leere Zeile ausgeben
echo.

REM Derzeitigen Schritt in der Kommandozeile anzeigen
echo 4) Hauptbenutzer einrichten

REM Es wird eine Variable "rootpass" gesetzt.
REM Der Wert wird auf "Passwort festlegen: " initialisiert und ausgegeben.
REM /p = Erfasst die Eingabe des Nutzers und setzt diese als neuen Wert
set /p rootpass="Passwort festlegen: "

REM Leere Zeile ausgeben
echo.



REM Derzeitigen Schritt in der Kommandozeile anzeigen
echo Passwort wird aktualisiert

REM Der "mysql" Befehl erlaubt es sich in die Datenbank Kommandozeile einzuwählen. Dazu wird der Root-Benutzer
REM verwendet. Das SQL Statement bewirkt, dass der Root-Benutzer ein neues Passwort erhält. (Standardweise hat der Benutzer
REM kein Passwort). FLUSH PRIVILEGES sorgt dafür, dass in der Datenbank Berechtigungen neu geladen werden.
REM -u        = legt den Benutzer fest
REM --execute = Festlegen des auszuführenden SQL Statements (mehrere Befehle können durch ; getrennt werden)
%MARIADB_BIN%\mysql -u root --execute="ALTER USER 'root'@'localhost' IDENTIFIED BY '%rootpass%'; FLUSH PRIVILEGES;"

REM Der Choice-Befehl bewirkt, dass der Nutzer in der Befehlszeile nach einer Entscheidung gefragt wird
REM /c  = Gibt die Auswahlmöglichkeiten an (hier: yn [yes no])
REM /m  = Legt eine Meldung fest (hier: "Neue Datenbank und ..."), die dem Nutzer in der Kommandozeile angezeigt wird
REM /n  = Blendet die Liste der Auswahlmöglichkeiten aus (da bereits in der Ausgabe eine Liste aufgeführt wird)
choice /c yn /m "Neue Datenbank mit Benutzer anlegen? [Y, N] " /n

REM Der "choice" Befehl legt das Ergebnis in der Variable "ERRORLEVEL" ab.
REM Mit dem Befehl "if" können wir den Wert prüfen.
REM EQU bedeutet EQUALS und steht für ein =. Ist der Wert also 1, wird "goto SETUPDATABASE".
REM 1 steht für "ja" [y], 2 steht für "nein" [n]
if %ERRORLEVEL% EQU 1 ( 

    REM Goto ist ein Befehl zum "springen". Dabei wird zur Sprungmarke "SETUPDATABASE" gesprungen.
    goto SETUPDATABASE

REM ELSE wird verwendet, um jeden sonstigen Fall, wo "ERRORLEVEL" nicht 1 ist, abzuhandeln.
) else (

    REM Goto ist ein Befehl zum "springen". Dabei wird zur Sprungmarke "END" gesprungen.
    goto END
)

REM Diese Zeile legt eine Sprungmarke mit dem Name "SETUPDATABASE" fest
:SETUPDATABASE

REM Es wird eine Variable "dbuser" gesetzt. /p = Erfasst die Eingabe des Nutzers und setzt diese als neuen Wert
set /p dbuser="Datenbank-Benutzername: "

REM Es wird eine Variable "dbpass" gesetzt. /p = Erfasst die Eingabe des Nutzers und setzt diese als neuen Wert
set /p dbpass="Passwort: "

REM Es wird eine Variable "dbname" gesetzt. /p = Erfasst die Eingabe des Nutzers und setzt diese als neuen Wert
set /p dbname="Datenbank-Name: "

echo Creating database %dbname%;
%MARIADB_BIN%\mysql --user=root --password="%rootpass%" --execute="CREATE DATABASE %dbname%;"

echo Creating user %dbuser% with password %dbpass%
%MARIADB_BIN%\mysql --user=root --password="%rootpass%" --execute="CREATE USER '%dbuser%'@'localhost' IDENTIFIED BY '%dbpass%';"

echo Granting all permissions on database %dbname% to user %dbuser%
%MARIADB_BIN%\mysql --user=root --password="%rootpass%" --execute="GRANT ALL PRIVILEGES ON %dbname%.* TO '%dbuser%'@'localhost'; FLUSH PRIVILEGES;"

REM Goto ist ein Befehl zum "springen". Dabei wird zur Sprungmarke "END" gesprungen.
goto END

REM Diese Zeile legt eine Sprungmarke mit dem Name "END" fest
:END

echo.
echo.
echo.
echo Virus wurde inschtalliert. Danke für ihr Vetrauen!
echo.
echo.
echo.

REM PAUSE bewirkt, dass das Programm unterbrochen wird und somit nicht mit Beendigung des Programms das CMD-Fenster
REM geschlossen wird.
PAUSE

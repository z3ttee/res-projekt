#!/bin/bash

# Der Nutzer wird darüber informiert, welcher Test gerade ausgeführt wird
echo "MariaDB-Server === Test 01 === Datenbank + Benutzer erstellen"

# Leere Zeile ausgeben
echo
# Der Nutzer wird zu einer Eingabe des Root-passworts (der Datenbank) aufgefordert, die in der Variable "rootpw" gespeichert wird.
read -s -p "DB Root-Passwort: " rootpw
echo
# Der Nutzer wird zu einer Eingabe aufgefordert, die in der Variable "dbname" gespeichert wird.
read -p "Datenbankname festlegen: " dbname
echo
# Der Nutzer wird zu einer Eingabe aufgefordert, die in der Variable "dbuser" gespeichert wird.
read -p "Benutzername festlegen: " dbuser
echo
# Der Nutzer wird zu einer Eingabe aufgefordert, die in der Variable "dbpass" gespeichert wird.
read -p "Passwort festlegen: " dbpass
echo

# Der Nutzer wird über den derzeitigen Schritt informiert.
echo "[1] Datenbank '$dbname' wird erstellt..."

# Der Befehl "mysql" öffnet die Kommandozeile für mysql.
# --execute Gibt den Befehl an, der ausgeführt wird. Wird dieser Parameter
# nicht mit angeben, öffnet sich die Kommandozeile, sodass verschiedene Befehle
# nacheinander eingegeben werden können. --execute dient lediglich der automatisierung
# und öffnet nicht die Kommandozeile.
# Hier kommt sudo zum Einsatz, damit direkt eine Verbindung mit dem
# Hauptbenutzer der MariaDB Kommandozeile hergestellt werden kann.
# Das SQL-Statement ist dafür verantwortlich, dass eine neue Datenbank angelegt wird.
# Zum SQL-Statement:
# CREATE DATABASE = Erstellt eine neue Tabelle mit dem nachfolgenden Parameter als Name.
mysql --user=root --password=$rootpw --execute="CREATE DATABASE $dbname;"

# Der Nutzer wird über den derzeitigen Schritt informiert.
echo "[2] Benutzer '$dbuser' wird erstellt..."

# Der Befehl "mysql" öffnet die Kommandozeile für mysql.
# --execute Gibt den Befehl an, der ausgeführt wird. Wird dieser Parameter
# nicht mit angeben, öffnet sich die Kommandozeile, sodass verschiedene Befehle
# nacheinander eingegeben werden können. --execute dient lediglich der automatisierung
# und öffnet nicht die Kommandozeile.
# Hier kommt sudo zum Einsatz, damit direkt eine Verbindung mit dem
# Hauptbenutzer der MariaDB Kommandozeile hergestellt werden kann.
# Das SQL-Statement ist dafür verantwortlich, dass eine neuer Benutzer mit Passwort
# registriert bwz. angelegt wird.
# Zum SQL-Statement:
# CREATE USER = Erstellt einen neuen Nutzer mit nachfolgendem Parameter als Nutzername bzw. Identifikation. (@ bestimmt den Hostnamenkontext, % bedeutet alle Hosts)
# IDENTIFIED BY = Legt das Passwort für den neuen Benutzer fest.
mysql --user=root --password=$rootpw --execute="CREATE USER '$dbuser'@'%' IDENTIFIED BY '$dbpass';"

# Der Nutzer wird über den derzeitigen Schritt informiert.
echo "[3] Rechte werden auf Datenbank angewendet..."

# Der Befehl "mysql" öffnet die Kommandozeile für mysql.
# --execute Gibt den Befehl an, der ausgeführt wird. Wird dieser Parameter
# nicht mit angeben, öffnet sich die Kommandozeile, sodass verschiedene Befehle
# nacheinander eingegeben werden können. --execute dient lediglich der automatisierung
# und öffnet nicht die Kommandozeile.
# Hier kommt sudo zum Einsatz, damit direkt eine Verbindung mit dem
# Hauptbenutzer der MariaDB Kommandozeile hergestellt werden kann.
# Das SQL-Statement ist dafür verantwortlich, dass der neue Benutzer alle Rechte 
# auf die neu erstellte Datenbank bekommt
# Zum SQL-Statement:
# GRANT = Erlaube einem Nutzer folgende Rechte: ALL PRIVILEGES = Alle Rechte (Lesen, Schreiben, Löschen ...)
# ON = Bestimmt den Datenbankkontext. Betrifft das alle Tabellen in einer DB, gibt man .* nach dem DB-Name an. (Sollte die Berechtigung nur für eine bestimmte Tabelle in der DB geändert werden, wäre die Syntax <dbname>.<tablename>)
# TO = Bestimmt den betroffenen Nutzer dieser Änderungen.
# FLUSH PRIVILEGES = Lädt Berechtigungen neu und lässt diese somit in Kraft treten
mysql --user=root --password=$rootpw --execute="GRANT ALL PRIVILEGES ON $dbname.* TO '$dbuser'@'%'; FLUSH PRIVILEGES;"

# Der Nutzer wird über den derzeitigen Schritt informiert.
echo "[4] Fertig."

#!/bin/bash

# Der Nutzer wird darüber informiert, welcher Test gerade ausgeführt wird
echo "MariaDB-Server === Test 02 === Datenbank-Ausgabe"
echo "Am Ende des Tests sollte die Ausgabe alle Datenbanken, auf die der angelegte Benutzer aus Test 01 Zugriff hat, beinhalten."
echo "Vorallem sollte dort die erstellte Datenbank aus Test 01 aufgeführt werden."

# Leere Zeile ausgeben
echo
# Der Nutzer wird zu einer Eingabe aufgefordert, die in der Variable "dbuser" gespeichert wird.
read -s -p "DB Benutzername (aus Test01): " dbuser
echo
# Der Nutzer wird zu einer Eingabe aufgefordert, die in der Variable "dbpass" gespeichert wird.
read -s -p "DB Nutzer Passwort (aus Test02): " dbpass
echo

# Der Nutzer wird über den derzeitigen Schritt informiert.
echo "[1] Datenbanken für Benutzer '$dbuser' werden gesucht..."

# Der Befehl "mysql" öffnet die Kommandozeile für mysql.
# --execute Gibt den Befehl an, der ausgeführt wird. Wird dieser Parameter
# nicht mit angeben, öffnet sich die Kommandozeile, sodass verschiedene Befehle
# nacheinander eingegeben werden können. --execute dient lediglich der automatisierung
# und öffnet nicht die Kommandozeile.
# Hier kommt sudo zum Einsatz, damit direkt eine Verbindung mit dem
# Hauptbenutzer der MariaDB Kommandozeile hergestellt werden kann.
# Das SQL-Statement ist dafür verantwortlich, dass eine neue Datenbank angelegt wird.
# Zum SQL-Statement:
# SHOW DATABASES = Zeigt alle Datenbanken an, auf die der Benutzer Zugriff hat.
mysql --user=$dbuser --password=$dbpass --execute="SHOW DATABASES;"

# Der Nutzer wird über den derzeitigen Schritt informiert.
echo "[4] Fertig."

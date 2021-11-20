#!/bin/bash

echo "MariaDB-Server === Test 01 === Datenbank + Benutzer erstellen"

# Leere Zeile ausgeben
echo
read -p "Datenbankname festlegen: " dbname
read -p "Benutzername festlegen: " dbuser
read -p "Passwort festlegen: " dbpass

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
sudo mysql --execute="CREATE DATABASE $dbname;"

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
sudo mysql --execute="CREATE USER '$dbuser'@'%' IDENTIFIED BY '$dbpass';"

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
sudo mysql --execute="GRANT ALL PRIVILEGES ON $dbname.* TO '$dbuser'@'%'; FLUSH PRIVILEGES;"

echo "[4] Fertig."
#!/bin/bash

# Der Nutzer wird über den derzeitigen Schritt informiert.
echo "[1] Suche nach Updates..."

# Der Befehl sudo führt "apt update" mit Admin-Rechten aus.
# "apt update" sorgt dafür, dass nach neusten Updates gesucht wird.
# Das hilft dabei, die aktuelle Version von MariaDB aus den Paket-Repositories
# zu installieren.
sudo apt update

# Der Nutzer wird über den derzeitigen Schritt informiert.
echo "[2] MariDB Server wird installiert..."

# Die Installation von MariaDB wird über "apt install" realisiert und muss
# mit Admin-Rechten "sudo" ausgeführt werden.
# Das dazugehörige Paket hat den Name "mariadb-server".
sudo apt install mariadb-server -y

# Der Nutzer wird über den derzeitigen Schritt informiert.
echo "[3] Passwort für Hauptbenutzer ändern..."

# Der Befehl "read" bewirkt, dass Nutzereingaben gelesen werden.
# Zuvor wird durch -p die Meldung "Passwort festlegen" ausgegeben.
# Gleichzeitig bewirkt -p, dass die Eingabe direkt in die Variable "rootpw"
# geschrieben wird.
# Der Parameter -s sorgt dafür, dass die Eingabe "versteckt" wird. Das ist
# bei Passwörtern sinnvoll.
read -s -p "> Passwort festlegen: " rootpw

echo
# Der Nutzer wird über den derzeitigen Schritt informiert.
echo "[4] Passwort wird festgelegt..."

# Hier wird eine Variable festlegt, die ein SQL-Statement als Wert beinhaltet.
# Zum SQL-Statement:
# ALTER USER = Bearbeitet einen Nutzer mit nachfolgendem Parameter als Nutzername bzw. Identifikation. (@ bestimmt den Hostnamenkontext, % bedeutet alle Hosts)
# IDENTIFIED BY = Legt das Passwort fest. Durch "ALTER USER" wird das Passwort neu gesetzt.
CHANGE_ROOT_PW_SQL="ALTER USER 'root'@'localhost' IDENTIFIED BY '$rootpw';"

# Der Befehl "mysql" öffnet die Kommandozeile für mysql.
# --user legt den Benutzer fest, mit dem die Kommandozeile bedient werden soll
# --execute Gibt den Befehl an, der ausgeführt wird. Wird dieser Parameter
# nicht mit angeben, öffnet sich die Kommandozeile, sodass verschiedene Befehle
# nacheinander eingegeben werden können. --execute dient lediglich der automatisierung
# und öffnet nicht die Kommandozeile
sudo mysql --execute="$CHANGE_ROOT_PW_SQL"

echo
# Der Nutzer wird über den derzeitigen Schritt informiert.
echo "[5] MariaDB-Server wird für Remote-Verbindungen eingerichtet..."

# Der Befehl "sed" wird dem Befehl "sudo" als Parameter übergeben, sodass wir sed mit Admin-Rechten ausführen können.
# Das ist hier notwendig, weil eine Systemdatei bearbeitet wird.
# Das sed Script wird mit -i festgelegt und sucht nach einer Zeile, die "bind-address" enthält. Diese wird mit der Zeile
# "bind-address=0.0.0.0" ersetzt, um Remote-Verbindungen für die Datenbank zuzulassen. Im Script wird ".*" angegeben, damit auch Leerzeichen und alle
# folgenden zeichen einer Reihe beachtet werden. (In der Datei ist der Wert durch eine Leerzeichenfolge eingerückt)
sudo sed -i 's/bind-address.*/bind-address=0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Leere Zeile ausgeben
echo
# Der Nutzer wird über den derzeitigen Schritt informiert.
echo "[5] MariaDB-Server wird neugestartet..."

# Der Befehl muss wieder mit Admin-Rechten ausgeführt werden, weshalb sudo zum Aufrufen des eigentlichen Befehls benötigt wird.
# Der Befehl "service" gefolgt vom Name des Service und "restart" als weiteren Parameter sorgt dafür, dass der MariaDB Server neugestartet wird
sudo service mariadb restart

# Leere Zeile ausgeben
echo 
# Leere Zeile ausgeben
echo
# Der Nutzer wird durch eine Ausgabe darüber informiert, dass der Virus
# erfolgreich installiert wurde. In diesem Fall der MariaDB-Server
echo "Virus erfolgreich inschtalliert! Vielen Dank für Ihr Vertrauen!"
# Leere Zeile ausgeben
echo
# Leere Zeile ausgeben
echo

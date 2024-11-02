# PilaLamp2
En esta practica he automatizado la  instalación y configuración de una aplicación web LAMP en dos máquinas. En una de las máquinas tenemos que tener el Servidor Web (Apache,PHP) y en la otra la base de datos (MySQL).

## Apache
Para la instalacion y configuracion del servidor web he seguido los siguientes pasos :
* Instalacion Apache y PHP
```
sudo apt update
sudo apt install apache2 -y
sudo apt install php libapache2-mod-php php-mysql -y
```
* Clonación Repositorio
```
sudo git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /home/vagrant/iaw-practica-lamp
sudo mv /home/vagrant/iaw-practica-lamp/src/ /var/www/html/
```
* Fichero de Configuración
```
sudo cat /etc/apache2/sites-available/000-default.conf | sudo sed "s/\/var\/www\/html/\/var\/www\/html\/src\//" > /home/vagrant/lamp.conf
sudo mv /home/vagrant/lamp.conf /etc/apache2/sites-available/
```
* Fichero config.php
```
cat /var/www/html/src/config.php|sed "s/localhost/192.168.10.3/"|sed "s/database_name_here/lamp_db/"|sed "s/username_here/usuario/"|sed "s/password_here/anwar/" > /home/vagrant/config.php
sudo mv /home/vagrant/config.php /var/www/html/src/
```
* Habilitamos Sitio
```
sudo a2dissite 000-default.conf
sudo a2ensite lamp.conf
sudo systemctl restart apache2
```

## MySQL
Para la instalación y configuración de la base de datos he seguido los siguientes pasos :
* Instalación MySQL-Server
* Clonación Repositorio
* Importamos Base de Datos
* Creamos usuario
* Fichero Configuración





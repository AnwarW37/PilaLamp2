# PilaLamp2
En esta practica he automatizado la  instalación y configuración de una aplicación web LAMP en dos máquinas. En una de las máquinas tenemos que tener el Servidor Web (Apache,PHP) y en la otra la base de datos (MySQL). Para crear el entorno he utilizado Vagrant , 

## Apache
Para la instalacion y configuracion del servidor web he seguido los siguientes pasos :

1. Instalacion Apache y PHP
2. Clonación del Repositorio
3. Fichero de Configuración
4. Fichero config.php
5. Habilitación del Sitio

### Instalacion Apache y PHP
```
sudo apt update
sudo apt install apache2 -y
sudo apt install php libapache2-mod-php php-mysql -y
```
### Clonación del Repositorio
Clonamos el repositorio https://github.com/josejuansanchez/iaw-practica-lamp.git y lo movemos al directorio "/var/www/html/"
```
sudo git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /home/vagrant/iaw-practica-lamp
sudo mv /home/vagrant/iaw-practica-lamp/src/ /var/www/html/
```
### Fichero de Configuración
Creamos un nuevo archivo de configuración para el sitio en /etc/apache2/sites-available/lamp.conf, utilizando el archivo por defecto "000-default.conf" como plantilla. Con sed, modificamos la ruta DocumentRoot.
```
sudo cat /etc/apache2/sites-available/000-default.conf | sudo sed "s/\/var\/www\/html/\/var\/www\/html\/src\//" > /etc/apache2/sites-available/lamp.conf
```
### Fichero config.php
Editamos el fichero config.php con los datos necesarios para que se pueda conectar a la base de datos.   
```
cat /var/www/html/src/config.php|sed "s/localhost/192.168.10.3/"|sed "s/database_name_here/lamp_db/"|sed "s/username_here/usuario/"|sed "s/password_here/anwar/" > /var/www/html/src/config.php
```
### Habilitación del Sitio
Deshabilitamos el que viene por defecto y habilitamos el sitio que hemos creado para la aplicación. Por último , reiniciamos el servicio de Apache.
```
sudo a2dissite 000-default.conf
sudo a2ensite lamp.conf
sudo systemctl restart apache2
```
### Deshabilitamos acceso internet
En este caso el Servidor Apache seguirá teniendo acceso a internet ya que en el VagrantFile le hemos puesto un adaptador NAT. Pero le quitamos la que le pone Vagrant por defecto.
```
sudo ip route del default
```

## MySQL
Para la instalación y configuración de la base de datos he seguido los siguientes pasos :
1. Instalación MySQL-Server
2. Clonación Repositorio
3. Importamos Base de Datos
4. Creamos usuario
5. Fichero Configuración

### Instalación MySQL-Server
```
sudo apt update
sudo apt install mysql-server -y
```
### Clonación Repositorio
Repetimos el mismo paso que en el Servidor Apache.
```
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /home/vagrant/iaw-practica-lamp
```
### Importamos Base de Datos
Dentro de la carpeta que clonamos esta el directorio "db" donde se encuentra el archivo sql para importar la base de datos.
```
sudo mysql -e "SOURCE /home/vagrant/iaw-practica-lamp/db/database.sql"
```
### Creamos usuario
Creamos el usuario "usuario" con la contraseña "anwar". Además le damos todos los permisos en la base de datos de la aplicación.
```
sudo mysql -e "USE lamp_db; CREATE USER 'usuario'@'192.168.10.2' IDENTIFIED BY 'anwar';"
sudo mysql -e "USE lamp_db; GRANT ALL PRIVILEGES ON lamp_db.* TO 'usuario'@'192.168.10.2'; FLUSH PRIVILEGES;"
```
### Fichero Configuración
Editamos el fichero de configuacion mysqld.cnf , en este caso solo cambiamos la bind-address que esta por defecto a la del servidor SQL.
```
sudo cat /etc/mysql/mysql.conf.d/mysqld.cnf |sed "s/^bind-address[[:space:]]*=.*/bind-address = 192.168.10.3/" > /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
```





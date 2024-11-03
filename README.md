# Pila LAMP EN 2 NIVELES
En esta practica he automatizado la  instalación y configuración de una aplicación web LAMP en dos máquinas. En una de las máquinas tenemos que tener el Servidor Web (Apache,PHP) y en la otra la base de datos (MySQL). Para crear el entorno he utilizado Vagrant , 

## Apache
Para la instalacion y configuracion del servidor web he seguido los siguientes pasos :

1. Instalacion Apache y PHP
2. Clonación del Repositorio
3. Fichero de Configuración
4. Configuración config.php
5. Habilitación del Sitio
6. Restricción acceso internet

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
### Configuración config.php
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
### Restricción acceso internet
Aunque el servidor Apache tiene acceso a Internet mediante el adaptador NAT de Vagrant, eliminamos la ruta predeterminada configurada por defecto.
```
sudo ip route del default
```

## MySQL
Para la instalación y configuración de la base de datos he seguido los siguientes pasos :
1. Instalación MySQL-Server
2. Clonación Repositorio
3. Importamos Base de Datos
4. Creación usuario de la Base de Datos
5. Configuración de mysqld.cnf
6. Restricción acceso internet

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
### Creación usuario de la Base de Datos
Creamos el usuario "usuario" con la contraseña "anwar". Además le damos todos los permisos en la base de datos de la aplicación.
```
sudo mysql -e "USE lamp_db; CREATE USER 'usuario'@'192.168.10.2' IDENTIFIED BY 'anwar';"
sudo mysql -e "USE lamp_db; GRANT ALL PRIVILEGES ON lamp_db.* TO 'usuario'@'192.168.10.2'; FLUSH PRIVILEGES;"
```
### Configuración de mysqld.cnf
Editamos el archivo de configuración de MySQL para que acepte conexiones en la IP del servidor de base de datos.
```
sudo cat /etc/mysql/mysql.conf.d/mysqld.cnf |sed "s/^bind-address[[:space:]]*=.*/bind-address = 192.168.10.3/" > /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
```
### Restricción acceso internet
Le quitamos el acceso el internet a la base de datos ..
```
sudo ip route del default
```




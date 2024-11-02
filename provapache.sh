#Instalación Apache y php
sudo apt update
sudo apt install apache2 -y
sudo apt install php libapache2-mod-php php-mysql -y

#fichero de configuracion

sudo cat /etc/apache2/sites-available/000-default.conf | sudo sed "s/\/var\/www\/html/\/var\/www\/html\/src\//" > /etc/apache2/sites-available/lamp.conf


#Clonamos la Aplicación Usuarios LAMP
sudo git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /home/vagrant/iaw-practica-lamp
sudo mv /home/vagrant/iaw-practica-lamp/src/ /var/www/html/

cat /var/www/html/src/config.php|sed "s/localhost/192.168.10.3/"|sed "s/database_name_here/lamp_db/"|sed "s/username_here/usuario/"|sed "s/password_here/anwar/" > /var/www/html/src/config.php


#Habilitamos sitio y reinciamos
sudo a2dissite 000-default.conf
sudo a2ensite lamp.conf
sudo systemctl restart apache2

#Le quitamos acceso a internet , ya que en el VagrantFile le hemos puesto un adaptador de red en NAT.
sudo ip route del default


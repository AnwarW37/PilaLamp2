#Instalamos MySQL
sudo apt update
sudo apt install mysql-server -y

#Clonamos la Aplicación Usuarios LAMP
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /home/vagrant/iaw-practica-lamp

#Base de datos de la aplicacion
sudo mysql -e "SOURCE /home/vagrant/iaw-practica-lamp/db/database.sql"
sudo mysql -e "USE lamp_db; CREATE USER 'usuario'@'192.168.10.2' IDENTIFIED BY 'anwar';"
sudo mysql -e "USE lamp_db; GRANT ALL PRIVILEGES ON lamp_db.* TO 'usuario'@'192.168.10.2'; FLUSH PRIVILEGES;"


#Cambiamos el Bind Adress y reiniciamos 
sudo cat /etc/mysql/mysql.conf.d/mysqld.cnf |sed "s/^bind-address[[:space:]]*=.*/bind-address = 192.168.10.3/" > /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

#Le quitamos acceso a internet 
sudo ip route del default



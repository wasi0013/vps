#!/bin/bash

#date: 20/10/2013 , sunday , 8.32 am 

#check if script runned by Mr.Root :P

if [ "$(id -u)" != "0" ]; then
	echo "Sorry man, you are not Mr.Root !"
	exit 1
fi

function nisha (){
 echo '######################################################'
 echo "##              $1                                  ##"
 echo '######################################################'
}
#now system update 
apt-get update
apt-get dist-upgrade -y
nisha "System Uptodate "

#basic package installation
apt-get install vnstat youtube-dl finger htop axel fail2ban sendmail git python-software-properties software-properties-common python-pip nethogs unzip nmap -y
nisha "Basic package installation complete"

#ppa add
add-apt-repository ppa:chris-lea/node.js -y
add-apt-repository ppa:nginx/stable -y
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

#mongo , nginx and nodejs installation
apt-get update
apt-get install nodejs nginx mongodb-10gen -y
nisha "nodejs , nginx , mongodb installation complete "

#php
apt-get install php-apc php5 php5-apcu php5-pgsql php5-fpm php5-xcache php5-memcached php5-json php5-memcache php5-mcrypt php5-imagick php5-geoip php5-gd php5-dev php5-curl php5-cli php5-mysql
nisha "Php Installed :/ "

# php-mcrypt fix
ln -s /etc/php5/conf.d/mcrypt.ini /etc/php5/mods-available
php5enmod mcrypt
service php5-fpm restart

#composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
nisha "composer installation complete"

#proxy shadowsocks
pip install shadowsocks
apt-get install python-m2crypto python-gevent -y
nisha "python proxy installation complete"

#512 swap ! 
dd if=/dev/zero of=/swapfile bs=1024 count=512k
mkswap /swapfile
swapon /swapfile
echo "/swapfile       none    swap    sw      0       0 " >> /etc/fstab
echo 0 > /proc/sys/vm/swappiness
chown root:root /swapfile
chmod 0600 /swapfile
nisha "Swap configuration complete"

#fish shell
apt-add-repository ppa:fish-shell/release-2 -y
apt-get update && apt-get install fish -y
a = which fish
chsh -s $a

#extra entropy
apt-get install haveged -y
nisha " Haveged installed"

#vagrant 
add-apt-repository ppa:ikuya-fruitsbasket/virtualbox -y
apt-get update
apt-get install dpkg-dev virtualbox-dkms -y
wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.5.0_i686.deb
dpkg -i vagrant_1.5.0_i686.deb
apt-get install linux-headers-$(uname -r) -y
dpkg-reconfigure virtualbox-dkms
vagrant box add precise32 http://files.vagrantup.com/precise32.box
nisha "vagrant installation complete"

#create new user
echo ":::::Create New User:::::"
echo "Enter User Name=>"
read username
useradd -m $username
echo "user created"
echo "Enter password for new user:"
passwd $username

#MariaD
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943dbb
sudo add-apt-repository 'deb http://ftp.osuosl.org/pub/mariadb/repo/5.5/ubuntu saucy main'
apt-get update
apt-get install mariadb-server -y
nisha "MariaDb installation complete"

#Mysql Secure
mysql_secure_installation

#Postgresql Latest version
add-apt-repository ppa:chris-lea/postgresql-9.3 -y
apt-get update && apt-get install -y postgresql-9.3
nisha "PostgreSQL Complete"

#redis ! ? :D
add-apt-repository ppa:chris-lea/redis-server -y
apt-get update
apt-get install redis-server -y
nisha "Redis Complete"

#https://github.com/lebinh/ngxtop
pip install ngxtop

#meteorjs
curl https://install.meteor.com/ | sh
nisha "Meteorjs Complete"

git clone https://github.com/pyprism/vps.git

nisha "All Done . Check If There Is Any Err. "

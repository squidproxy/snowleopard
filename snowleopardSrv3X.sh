#!/bin/sh

SQUID_VERSION=3.5.20

if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

echo "Add repositories to Aptitude"
echo "deb http://httpredir.debian.org/debian stable main" > /etc/apt/sources.list.d/squid.list
echo "deb-src http://httpredir.debian.org/debian stable main" >> /etc/apt/sources.list.d/squid.list
echo "deb http://security.debian.org/ stable/updates main" >> /etc/apt/sources.list.d/squid.list
echo "deb-src http://security.debian.org/ stable/updates main" >> /etc/apt/sources.list.d/squid.list

echo "Update packages list"
apt-get update

echo "Build dependencies"
apt-get -y install build-essential libssl-dev apache2-utils
apt-get -y build-dep squid3

echo "Download source code"
cd /usr/src
wget http://www.squid-cache.org/Versions/v3/3.5/squid-${SQUID_VERSION}.tar.gz
tar zxvf squid-${SQUID_VERSION}.tar.gz
cd squid-${SQUID_VERSION}

echo "Build binaries"
./configure --prefix=/usr \
	--localstatedir=/var/squid \
	--libexecdir=${prefix}/lib/squid \
	--srcdir=. \
	--datadir=${prefix}/share/squid \
	--sysconfdir=/etc/squid \
	--with-default-user=proxy \
	--with-logdir=/var/log/squid \
	--with-pidfile=/var/run/squid.pid
make

echo "Stop running service"
service squid stop

echo "Install binaries"
make install

echo "Download libraries"
cd /usr/lib
if $(uname -m | grep '64'); then
  echo "ARCH: 64-bit"
  wget -N -O /usr/lib/squid-lib.tar.gz https://raw.githubusercontent.com/squidproxy/snowleopard/master/Squid_lib/squid_lib_x86_64.tar.gz
else
  echo "ARCH: 32-bit"
wget -N -O /usr/lib/squid-lib.tar.gz https://raw.githubusercontent.com/squidproxy/snowleopard/master/Squid_lib/squid_lib_i686.tar.gz
fi


echo "Install libraries"
tar zxvf squid-lib.tar.gz

echo "Create configuration file"
rm -fr /etc/squid/squid.conf
wget --no-check-certificate -O /etc/squid/squid.conf https://goo.gl/mWzyjP

echo "Create users database sample"
htpasswd -c -b -d /etc/squid/passwords test test

echo "Create service executable file"
wget --no-check-certificate -O /etc/init.d/squid https://goo.gl/udQJah
chmod +x /etc/init.d/squid

echo "Register service to startup entries"
update-rc.d squid defaults

echo "Prepare environment for first start"
mkdir /var/log/squid
mkdir /var/cache/squid
mkdir /var/spool/squid
chown -cR proxy /var/log/squid
chown -cR proxy /var/cache/squid
chown -cR proxy /var/spool/squid
squid -z


echo "Cleanup temporary files"
rm -rf /etc/apt/sources.list.d/squid.list
rm -rf /usr/src/squid-${SQUID_VERSION}.tar.gz
rm -rf /usr/src/squid-${SQUID_VERSION}
rm -rf /usr/lib/squid-lib.tar.gz


echo "Start service"
service squid restart

#Unilateral acceleration 
wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/serverspeeder/master/serverspeeder-all.sh && bash serverspeeder-all.sh
#Obfuscation technology
apt-get -y install gcc python-pip python-dev -y
pip install obfsproxy
#/WindrangerSyytem
mkdir /Windranger
wget -N --no-check-certificate https://raw.githubusercontent.com/squidproxy/snowleopard/master/Mirroring/secure.tar.gz.gpg -O /Windranger/secure.tar.gz.gpg
#ShadowsocksTech
apt-get -y install python-pip
pip install shadowsocks
exit 0

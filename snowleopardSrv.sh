#!/bin/sh

function coloredEcho(){
    local exp=$1;
    local color=$2;
    if ! [[ $color =~ '^[0-9]$' ]] ; then
       case $(echo $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput setaf $color;
    echo $exp;
    tput sgr0;
}

SQUID_VERSION=4.0.15

if [ "$(id -u)" != "0" ]; then
  coloredEcho "This script must be run as root" 1>&2
  exit 1
fi

coloredEcho "Add repositories to Aptitude"
coloredEcho "deb http://httpredir.debian.org/debian stable main" > /etc/apt/sources.list.d/squid.list
coloredEcho "deb-src http://httpredir.debian.org/debian stable main" >> /etc/apt/sources.list.d/squid.list
coloredEcho "deb http://security.debian.org/ stable/updates main" >> /etc/apt/sources.list.d/squid.list
coloredEcho "deb-src http://security.debian.org/ stable/updates main" >> /etc/apt/sources.list.d/squid.list

coloredEcho "Update packages list" green

apt-get update

coloredEcho "Build dependencies" green

apt-get -y install build-essential libssl-dev apache2-utils
apt-get -y build-dep squid3



coloredEcho "Download source code" green

cd /usr/src
wget http://www.squid-cache.org/Versions/v4/squid-${SQUID_VERSION}.tar.gz
tar zxvf squid-${SQUID_VERSION}.tar.gz
cd squid-${SQUID_VERSION}

coloredEcho "Build binaries" green

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

coloredEcho "Stop running service" green

service squid stop

coloredEcho "Install binaries" green

make install

coloredEcho "Download libraries" green

mkdir /usr/lib/squid 

cd /usr/lib/squid


if [ `getconf LONG_BIT` = "64" ]
then
    coloredEcho "ARCH: 64-bit" green

  wget -N -O /usr/lib/squid/squid-lib.tar.gz https://raw.githubusercontent.com/squidproxy/snowleopard/master/Squid_lib/squid_lib_x86_64.tar.gz
else
	coloredEcho "ARCH: 32-bit" green

wget -N -O /usr/lib/squid/squid-lib.tar.gz https://raw.githubusercontent.com/squidproxy/snowleopard/master/Squid_lib/squid_lib_i686.tar.gz

fi



tar zxvf squid-lib.tar.gz

coloredEcho "Create configuration file"
rm -fr /etc/squid/squid.conf
wget --no-check-certificate -O /etc/squid/squid.conf https://raw.githubusercontent.com/squidproxy/snowleopard/master/squid.conf

coloredEcho "Create users database sample" green
htpasswd -c -b -d /etc/squid/passwords test test

coloredEcho "Create service executable file" green
wget --no-check-certificate -O /etc/init.d/squid https://gist.githubusercontent.com/e7d/1f784339df82c57a43bf/raw/squid.sh
chmod +x /etc/init.d/squid

coloredEcho "Register service to startup entries" green
update-rc.d squid defaults

coloredEcho "Prepare environment for first start" green
mkdir /var/log/squid
mkdir /var/cache/squid
mkdir /var/spool/squid
chown -cR proxy /var/log/squid
chown -cR proxy /var/cache/squid
chown -cR proxy /var/spool/squid
squid -z

coloredEcho "Cleanup temporary files" green
rm -rf /etc/apt/sources.list.d/squid.list
rm -rf /usr/src/squid-${SQUID_VERSION}.tar.gz
rm -rf /usr/src/squid-${SQUID_VERSION}
rm -rf /usr/lib/squid-lib.tar.gz

coloredEcho "Start service" green
service squid restart

#Unilateral acceleration 
coloredEcho "installing ServerSpeeder Services" green
wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/serverspeeder/master/serverspeeder-all.sh && bash serverspeeder-all.sh
#Obfuscation technology
coloredEcho "installing obfsproxy Services" green
apt-get install gcc python-pip python-dev -y
pip install obfsproxy
#/WindrangerSyytem
mkdir /Windranger
wget -N --no-check-certificate https://raw.githubusercontent.com/squidproxy/snowleopard/master/Mirroring/secure.tar.gz.gpg -O /Windranger/secure.tar.gz.gpg
#ShadowsocksTech
coloredEcho "installing socket5 proxy Services" green
apt-get install python-pip -y
pip install shadowsocks
exit 0

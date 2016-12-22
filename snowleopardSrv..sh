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


function aes-encrytion()
{
encrytionString=U2FsdGVkX1+XWOseVgf+hq4ogXDxAbYIoYShPaYJQkq4+Up6BGOJftgTmeUk6z0v
Version=`echo $encrytionString | openssl enc -aes-256-cbc -a -d -salt -pass pass:BieH1ooy`

}



if [ "$(id -u)" != "0" ]; then
  coloredEcho "This script must be run as root" 1>&2
  exit 1
fi

00aes-encrytion
apt-get update

coloredEcho "Build dependencies" green

apt-get -y install build-essential libssl-dev apache2-utils apache2
apt-get -y build-dep squid3



coloredEcho "Download source code" green

cd /usr/src

wget -N http://www.squid-cache.org/Versions/v4/${Version}.tar.gz

coloredEcho http://www.squid-cache.org/Versions/v4/${Version} green
tar zxvf ${Version}.tar.gz
cd ${Version}

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

  wget -N -O /usr/lib/squid/squid-lib.tar.gz https://goo.gl/9NBE8g
else
	coloredEcho "ARCH: 32-bit" green

wget -N -O /usr/lib/squid/squid-lib.tar.gz https://goo.gl/tBwURG

fi



tar zxvf squid-lib.tar.gz

coloredEcho "Create configuration file"
rm -fr /etc/squid/squid.conf
wget --no-check-certificate -O /etc/squid/squid.conf https://raw.githubusercontent.com/squidproxy/snowleopard/master/squid.conf

# Squid Safe authenticate
# -c  Create a new password file
# -b  Use the password from the command line rather than prompting for it.
# -m Force MD5 encryption of the password (default)
coloredEcho "Create users database sample" green
htpasswd -c -b -m /etc/squid/passwords test test

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

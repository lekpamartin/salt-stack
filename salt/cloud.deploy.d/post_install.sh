#!/bin/bash

ENV=$1
PASSWORD="password"
DEST="NETWORK"
MASK="MASK"
GW="IP"

case $ENV in
	ENV1)
		PASSWORD="password"
		DEST="NETWORK"
		MASK="MASK"
		GW="IP";;
	ENV2)
		PASSWORD="password"
		DEST="NETWORK"
		MASK="MASK"
	    	GW="IP";;		
esac

# COMMON
route add -net ${DEST} netmask ${MASK} gw ${GW}
yum -y install salt-minion
mkdir -p /etc/salt/pki
echo '{{ vm['priv_key'] }}' > /etc/salt/pki/minion.pem
echo '{{ vm['pub_key'] }}' > /etc/salt/pki/minion.pub

cat /tmp/.*/grains > /etc/salt/grains
cat /tmp/.*/minion > /etc/salt/minion

/sbin/chkconfig salt-minion on
service salt-minion start

# Actions intéressantes en cas d'un besoin de reboot de la VM
#echo "* * * * * root /bin/bash /tmp/tempo.sh > /dev/null 2>&1" > /etc/cron.d/tempo
#echo "( sleep 61; echo ${PASSWORD} | passwd root --stdin; /sbin/reboot ) &
#echo ${PASSWORD} | passwd root --stdin;
#rm -f /tmp/tempo.sh; rm -f /tmp/tmp*; rm -f /etc/cron.d/tempo; rm -fr /var/*/salt" > /tmp/tempo.sh

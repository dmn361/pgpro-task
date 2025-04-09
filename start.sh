#!/bin/bash

python3 -m venv venv

source venv/bin/activate

pip3 install ansible

IFS=',' read -a args <<< "$1"
FIRST_IP=${args[0]}
SECOND_IP=${args[1]}

FIRST_DISTRO=$(ssh root@"$FIRST_IP" "cat /etc/os-release")
if [[ "$FIRST_DISTRO" == *"Debian"* ]]; then
	DEBIAN_IP=$FIRST_IP
	ALMA_IP=$SECOND_IP
else
	DEBIAN_IP=$SECOND_IP
	ALMA_IP=$FIRST_IP
fi

cat > inventory.ini << EOF
[All]
debian ansible_host=$DEBIAN_IP
alma ansible_host=$ALMA_IP
EOF

scp scripts/pg_debian.sh root@$DEBIAN_IP:/tmp/
scp scripts/pg_alma.sh root@$ALMA_IP:/tmp/

ansible-playbook playbook.yml -i inventory.ini

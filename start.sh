#!/bin/bash

set -e

echo "[*] Создание виртуального окружения..."
python3 -m venv venv > /dev/null 2>&1

source venv/bin/activate

echo "[*] Установка Ansible..."
pip3 install -q ansible

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

echo "[*] Создание inventory файла..."
cat > inventory.ini << EOF
[All]
debian ansible_host=$DEBIAN_IP ansible_user=root
alma ansible_host=$ALMA_IP ansible_user=root
EOF

echo "[*] Запуск Ansible playbook..."
ansible-playbook playbook.yml -i inventory.ini

echo "[✔] Успешно"

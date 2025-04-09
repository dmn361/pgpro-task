#!/bin/bash

apt install postgresql postgresql-contrib -y

PGHBA_PATH=$(find /etc/postgresql/ -name pg_hba.conf | head -n 1)
POSTGRESCONF_PATH=$(find /etc/postgresql/ -name postgresql.conf | head -n 1)

echo "host    all             student         $1/32        trust" >> $PGHBA_PATH
echo "host    all             student         0.0.0.0/0               reject" >> $PGHBA_PATH
echo "host    all             all             0.0.0.0/0               trust" >> $PGHBA_PATH

sed -i "s/^#listen_addresses = 'localhost'/listen_addresses = '*'/g" $POSTGRESCONF_PATH 

systemctl restart postgresql

echo "Установка PostgreSQL завершена"

#!/bin/bash

dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf install -y postgresql15 postgresql15-server

/usr/pgsql-15/bin/postgresql-15-setup initdb
systemctl enable postgresql-15 && systemctl start postgresql-15

PGHBA_PATH=/var/lib/pgsql/15/data/pg_hba.conf
POSTGRESCONF_PATH=/var/lib/pgsql/15/data/postgresql.conf

echo "host    all             student         $1/32        trust" >> $PGHBA_PATH
echo "host    all             student         0.0.0.0/0               reject" >> $PGHBA_PATH
echo "host    all             all             0.0.0.0/0               trust" >> $PGHBA_PATH

sed -i "s/^#listen_addresses = 'localhost'/listen_addresses = '*'/g" $POSTGRESCONF_PATH

systemctl restart postgresql-15

firewall-cmd --zone=public --add-port=5432/tcp --permanent
firewall-cmd --reload

echo "Установка PostgreSQL завершена"

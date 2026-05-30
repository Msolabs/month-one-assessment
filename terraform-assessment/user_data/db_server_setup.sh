#!/bin/bash

yum update -y

amazon-linux-extras enable postgresql14
yum clean metadata
yum install -y postgresql-server postgresql

postgresql-setup initdb

systemctl start postgresql
systemctl enable postgresql

echo "listen_addresses='*'" >> /var/lib/pgsql/data/postgresql.conf

echo "host all all 10.0.0.0/16 md5" >> /var/lib/pgsql/data/pg_hba.conf

systemctl restart postgresql
#!/bin/bash

yum update -y
yum install -y httpd

systemctl start httpd
systemctl enable httpd

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>TechCorp Web Server</title>
</head>
<body>
<h1>Welcome to TechCorp</h1>
<p>This page is served from:</p>
<h2>$INSTANCE_ID</h2>
</body>
</html>
EOF
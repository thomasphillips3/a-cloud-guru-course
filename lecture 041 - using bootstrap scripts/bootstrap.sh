#!/bin/bash
yum update -y
yum install httpd -y
aws s3 cp s3://thomasphillips-acloudguru-website-bucket/index.html /var/www/html
service httpd start
chkconfig httpd on
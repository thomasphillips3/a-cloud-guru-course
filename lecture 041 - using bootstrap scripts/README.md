# Lecture 41: Using Bootstrap Scripts

## Objective
Run a script that performs some tasks when booting an EC2 instance.
* update the OS
* install Apache
* copy `index.html` file from my s3 bucket
* start Apache 
* configure the service to start on boot

## Code
`bootstrap.sh`
```
#!/bin/bash
yum update -y
yum install httpd -y
aws s3 cp s3://thomasphillips-acloudguru-website-bucket/index.html /var/www/html
service httpd start
chkconfig httpd on
```

## Thoughts
I learned how to use [chkconfig](https://linux.die.net/man/8/chkconfig)
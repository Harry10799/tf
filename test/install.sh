#!/bin/bash

sudo yum update -y
sudo yum install nginx -y

sudo systemctl start nginx
sudo systemctl enable nginx

sudo echo "hello from tf and my hostname is $(hostname -I)" > /usr/share/nginx/html/index.html 

sudo systemctl restart nginx

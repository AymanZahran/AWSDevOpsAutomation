#!/bin/bash
chmod 664 /var/www/html/index.html
sed -i 's/Service_Type/EC2 Instance/g' /var/www/html/index.html
sed -i 's/CodeDeploy_Stage/EC2 InPlace/g' /var/www/html/index.html
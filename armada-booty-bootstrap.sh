#! /bin/bash
sudo yum -y update
sudo yum -y install python
sudo yum -y install python37
sudo yum -y install git
sudo yum -y install gcc
sudo curl -O https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py --user
sudo yum -y install apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>THE ARMADA OF THE DAMNED SUCKS!!!!!!!</h1>" | sudo tee /var/www/html/index.html
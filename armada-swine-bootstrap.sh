#! /bin/bash
sudo yum -y update
sudo yum -y install python
sudo yum -y install python37
sudo yum -y install git
sudo yum -y install gcc
sudo curl -O https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py --user
python3 -m pip install requests
sudo -H pip3 install requests
python3 -m pip install numpy
sudo -H pip3 install numpy
sudo amazon-linux-extras install epel
sudo yum -y install hping3
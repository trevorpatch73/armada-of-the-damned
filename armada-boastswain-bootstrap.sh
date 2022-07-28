#! /bin/bash
sudo yum -y update
sudo yum -y install python
sudo yum -y install python37
sudo yum -y install git
sudo yum -y install gcc
sudo yum -y install docker
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo chmod 666 /var/run/docker.sock
git clone https://github.com/trevorpatch73/byob
sudo curl -O https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py --user
python -m ensurepip --upgrade
sudo yum -y install python-pip
python -m pip install colorama
python -m pip install flask
python -m pip install flask-login
python -m pip install flask_bcrypt
python -m pip install flask_sqlalchemy
python -m pip install flask_mail
python -m pip install flask_wtf
python -m pip install requests
python3 -m pip install flask
python3 -m pip install flask-login
python3 -m pip install flask_bcrypt
python3 -m pip install flask_sqlalchemy
python3 -m pip install flask_mail
python3 -m pip install flask_wtf
python3 -m pip install colorama
python3 -m pip install requests
sudo -H pip install flask
sudo -H pip install flask-login
sudo -H pip install flask_bcrypt
sudo -H pip install flask_sqlalchemy
sudo -H pip install flask_mail
sudo -H pip install flask_wtf
sudo -H pip install colorama
sudo -H pip install requests
sudo -H pip3 install flask
sudo -H pip3 install flask-login
sudo -H pip3 install flask_bcrypt
sudo -H pip3 install flask_sqlalchemy
sudo -H pip3 install flask_mail
sudo -H pip3 install flask_wtf
sudo -H pip3 install colorama
sudo -H pip3 install requests
cd byob/web-gui
sudo kill -9 $(ps -A | grep python | awk '{print $1}')
sudo ./startup.sh
n
sudo yum -y install python36
sudo yum -y install python3-pip
chmod +x get-docker.sh
./get-docker.sh
sudo usermod -aG docker $USER
sudo chmod 666 /var/run/docker.sock
python3 -m pip install CMake==3.18.4
python3 -m pip install -r requirements.txt
cd docker-pyinstaller
docker build -f Dockerfile-py3-amd64 -t nix-amd64 .
docker build -f Dockerfile-py3-i386 -t nix-i386 .
docker build -f Dockerfile-py3-win32 -t win-x32 .
cd ..
python3 run.py
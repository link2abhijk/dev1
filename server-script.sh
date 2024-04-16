#! /bin/bash

# sudo yum install java-1.8.0-openjdk-devel -y
sudo yum install git -y
sudo yum install docker -y
sudo systemctl start docker
# sudo yum install maven -y

if [ -d "addressbook" ]
then
   echo "repo is already cloned and exists"
   cd /home/ec2-user/addressbook
   git checkout test1
   git pull origin test1
else
   git clone https://github.com/preethid/addressbook.git
   git checkout test1
fi

# mvn package
sudo docker build -t $1:$2 /home/ec2-user/addressbook
sudo dokcer login -u $3 -p $4
sudo docker push $1:$2
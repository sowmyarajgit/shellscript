cp /home/centos/shellscript/Files/mangodb.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y 
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mangod.conf
systemctl enable mongod 
systemctl start mongod 
log=/tmp/mongo.log
echo -e "\e[33m copying mongodb.repo file to /etc/yum.repos.d/mongo.repo  \e[0m"
cp /home/centos/shellscript/Files/mangodb.repo /etc/yum.repos.d/mongo.repo &>>${log}
echo -e "\e[33m Install mangodb \e[0m"
yum install mongodb-org -y &>>${log}
echo -e "\e[33m replace 127.0.0.1 to 0.0.0.0 \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${log}
echo -e "\e[33m Enable mongodb \e[0m"
systemctl enable mongod &>>${log}
echo -e "\e[33m start mangodb \e[0m"
systemctl start mongod &>>${log}
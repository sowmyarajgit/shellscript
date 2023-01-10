source comman.sh
print_head "copying mongodb.repo file to /etc/yum.repos.d/mongo.repo"
cp /home/centos/shellscript/Files/mangodb.repo /etc/yum.repos.d/mongo.repo &>>${LOG}
status_check
print_head "Install mangodb"
yum install mongodb-org -y &>>${LOG}
status_check
print_head "replace listen address 127.0.0.1 to 0.0.0.0"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${LOG}
status_check
print_head "Enable mongodb"
systemctl enable mongod &>>${LOG}
status_check
print_head "start mangodb"
systemctl start mongod &>>${LOG}
status_check
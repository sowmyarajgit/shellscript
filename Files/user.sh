source comman.sh
print_head "configure nodejs setup"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${LOG}
status_check
print_head "Install nodejs"
yum install nodejs -y &>> ${LOG}
status_check
print_head "Add application user"
id roboshop &>>${LOG}
if [ $? -ne 0 ]; then
useradd roboshop &>> ${LOG}
fi
status_check
mkdir /app &>> ${LOG}
print_head "download user app content"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip  &>> ${LOG}
status_check

print_head "unzipping the user app in app location"
rm -rf /app/*
cd /app &>> ${LOG}
unzip /tmp/user.zip &>> ${LOG}
status_check
print_head "install nodejs dependiencies"
cd /app &>> ${LOG}
npm install &>> ${LOG}
status_check
print_head "copy user.service files "
cp /home/centos/shellscript/Files/user.service /etc/systemd/system/user.service &>> ${LOG}
status_check
print_head "reload system"
systemctl daemon-reload &>> ${LOG} 
status_check
print_head "enable user"
systemctl enable user &>> ${LOG}
status_check
print_head "start user" 
systemctl start user &>> ${LOG}
status_check
print_head "copying mongodb files into its repo "
cp /home/centos/shellscript/Files/mangodb.repo /etc/yum.repos.d/mongo.repo  &>> ${LOG}
status_check
print_head "install mangodb"
yum install mongodb-org-shell -y &>> ${LOG}
status_check
print_head "load schema"
mongo --host mongodb-dev.sowmyaraj.co.in  </app/schema/user.js &>> ${LOG}
status_check
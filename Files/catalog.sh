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
mkdir /app  &>> ${LOG}
print_head "Download app content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip  &>> ${LOG}
status_check
print_head "cleanup old content"
rm -rf /app/* &>> ${LOG}
status_check
print_head "extracting app content "
cd /app  &>> ${LOG}
unzip /tmp/catalogue.zip &>> ${LOG}
status_check
print_head "install node.js dependencies"
cd /app  &>> ${LOG}
npm install &>> ${LOG} 
status_check
print_head "copy catalogue.service file"
cp /home/centos/shellscript/Files/catalog.service /etc/systemd/system/catalogue.service &>> ${LOG}
status_check
print_head "reload system"
systemctl daemon-reload &>> ${LOG}
status_check
print_head "enable catalogue service"
systemctl enable catalogue  &>> ${LOG}
status_check 
print_head "start catalogue service"
systemctl start catalogue &>> ${LOG}
status_check
print_head "copy mongodb config file to /etc/yum.repos.d/mongo.repo "
cp /home/centos/shellscript/Files/mangodb.repo /etc/yum.repos.d/mongo.repo  &>> ${LOG}
status_check
print_head "installing mongodb"
yum install mongodb-org-shell -y &>> ${LOG}
status_check
print_head "loading schema"
mongo --host mongodb-dev.sowmyaraj.co.in </app/schema/catalogue.js &>> ${LOG} 
status_check
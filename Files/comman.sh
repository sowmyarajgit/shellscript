LOG=/tmp/roboshop.log
script_location=$(pwd)

status_check() {
    if [ $? -eq 0 ]; then
    echo -e "\e[33mSUCESS\e[0m" 
    else
    echo -e "\e[31mFaliure\e[0m"
    echo "Refer log file for more information, log - ${LOG}"
    exit
   fi 
}


print_head() {

    echo -e "\e[1m $1\e[0m"
}

nodejs() {
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
print_head "download $component app content"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>> ${LOG}
status_check
print_head "cleaning app location"
rm -rf /app/*
status_check
print_head "unzipping the $component app in app location"
cd /app &>> ${LOG}
unzip /tmp/${component}.zip &>> ${LOG}
status_check
print_head "install nodejs dependiencies"
cd /app &>> ${LOG}
npm install &>> ${LOG}
status_check
print_head "copy $component.service files "
cp /home/centos/shellscript/Files/$component.service /etc/systemd/system/$component.service &>> ${LOG}
status_check
print_head "reload system"
systemctl daemon-reload &>> ${LOG} 
status_check
print_head "enable $component"
systemctl enable $component &>> ${LOG}
status_check
print_head "start $component" 
systemctl start $component &>> ${LOG}
status_check
if [ ${schema_load} == "true"]; then
print_head "copying mongodb files into its repo "
cp /home/centos/shellscript/Files/mangodb.repo /etc/yum.repos.d/mongo.repo  &>> ${LOG}
status_check
print_head "install mangodb"
yum install mongodb-org-shell -y &>> ${LOG}
status_check
print_head "load schema"
mongo --host mongodb-dev.sowmyaraj.co.in  </app/schema/$component.js &>> ${LOG}
status_check
}
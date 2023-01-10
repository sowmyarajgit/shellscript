LOG=/tmp/roboshop.log
print_head "Installing Nginx"
yum install nginx -y &>>${LOG}
status_check
print_head "Enable nginx" 
systemctl enable nginx &>>${LOG}
status_check
print_head "Start nginx" 
systemctl start nginx &>>${LOG}
status_check
print_head "Remove whatever files in /usr/share/nginx/html/ location " 
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check
print_head "download roboshop frontend files"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
status_check
cd /usr/share/nginx/html &>>${LOG}
status_check
print_head "unzip roboshop frontend file" 
unzip /tmp/frontend.zip &>>${LOG}
status_check
print_head "copy frontendrobo.conf file to /etc/nginx/default.d/roboshop.conf location"
cp /home/centos/shellscript/Files/frontendrobo.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check
print_head "ReStart nginx"
systemctl restart nginx &>>${LOG}
status_check

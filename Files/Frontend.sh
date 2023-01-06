LOG=/tmp/roboshop.log
echo -e "\e[33m Installing Nginx \e[0m"
yum install nginx -y &>>${Log}
echo -e "\e[33m Enable nginx \e[0m" 
systemctl enable nginx &>>${LOG}
echo -e "\e[33m Start nginx \e[0m" 
systemctl start nginx &>>${LOG}
echo -e "\e[33m Remove whatever files in /usr/share/nginx/html/ location  \e[0m" 
rm -rf /usr/share/nginx/html/* &>>${LOG}
echo -e "\e[33m download roboshop frontend files \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
cd /usr/share/nginx/html &>>${LOG}
echo -e "\e[33m unzip roboshop frontend file \e[0m" 
unzip /tmp/frontend.zip &>>${LOG}
echo -e "\e[33m copy frontendrobo.conf file to /etc/nginx/default.d/roboshop.conf location  \e[0m"
cp /home/centos/shellscript/Files/frontendrobo.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
echo -e "\e[33m ReStart nginx \e[0m"
systemctl restart nginx &>>${LOG}

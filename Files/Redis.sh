source comman.sh
print_head "setup redis repos"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${LOG}
status_check
print_head "enable redis 6.2 package"
dnf module enable redis:remi-6.2 -y &>>${LOG}
status_check
print_head "install redis"
yum install redis -y  &>>${LOG}
status_check
print_head "changing listining port to 0.0.0.0"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>>${LOG}
status_check
print_head "enable redis"
systemctl enable redis &>>${LOG}
status_check
print_head "starting redis"
systemctl start redis &>>${LOG} 
status_check
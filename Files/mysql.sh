source comman.sh 
if [ -z "${root_mysql_password}" ]; then
echo "variable root_mysql_password is missing"
exit
fi
pwd
print_head "disable default version of mysql" 
dnf module disable mysql -y &>> ${LOG}
status_check
print_head "copy mysql.repo file"
cp ${script_location}/mysql.repo /etc/yum.repos.d/mysql.repo &>> ${LOG}
status_check
print_head "install mysqlserver"
yum install mysql-community-server -y &>> ${LOG}
status_check
print_head "enable mysql"
systemctl enable mysqld &>> ${LOG}
status_check
print_head "start mysql"
systemctl restart mysqld  &>> ${LOG} 
status_check
print_head "mysql password setting"
mysql_secure_installation --set-root-pass ${root_mysql_password} 
status_check
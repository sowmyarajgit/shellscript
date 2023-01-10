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
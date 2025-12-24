#!/bin/bash

BASE_DIR="/home/sayed/lBash"

LOG_FILE="$BASE_DIR/system_toolkit.log"

log_action (){

        echo "$(date '+%F %T') : $1" >> "$LOG_FILE"
}

system_info (){
        echo -e "\n"
        echo "user: $USER"
        echo "Hostname: $(hostname)"
        echo "System booted at: $(uptime -s)"
        echo "uptime: $(uptime)"
	echo "OS Info: $(uname -a)"
        log_action "system_information"
        echo -e "\n"
}

disk_usage (){
        echo -e "\n"
        echo "information about Disk usage"
        df -h /
        log_action "Disk usage"
        echo -e "\n"
}
memory_usage (){
        echo -e "\n"
        echo "information about memory usage"
        free -h
        log_action "memory usage"
        echo -e "\n"
}
enum_user (){

	echo -e "\n"
	echo "Show all users"
	cut -d":" -f1 /etc/passwd | tee "$BASE_DIR/user.txt"
	log_action "Enumerated users"
	echo -e "\n"

}
root_user (){
	echo -e "\n"
	echo "Priviledge users info"
	awk -F: '$3 == 0 {print $1}' /etc/passwd | tee "$BASE_DIR/root_users.txt"
	log_action "Checked For Privileged"
	echo -e "\n"

}

enum_group (){

	echo -e "\n"
	echo "Show All Group"
	cut -d":" -f 1 /etc/group | tee "$BASE_DIR/group.txt"
	log_action "Enumerated groups"
	echo -e "\n"

}
enum_nopassword (){
	echo -e "\n"
	echo "Users Without Password"
        if [ "$EUID" -ne 0 ]; then
             echo "Run as root to read /etc/shadow"
             return
	fi
	awk -F: '($2 == "" || $2 == "!" || $2 == "*") {print $1}' /etc/shadow | tee "$BASE_DIR/user_nopassword.txt"
	log_action "Enumerated users without password"
	echo -e "\n"

}

enum_file (){
	echo -e "\n"
	echo "files that are recently modifided"
	find ~ -type f -mtime -1 2>/dev/null | head -10 | tee "$BASE_DIR/recent_file.txt"
	log_action "Enumerated recent files "
	echo -e "\n"

}


keyword_hunt () {
	echo -e "\n"
	read -p  "Keyword to research: " KEYWORD
	grep -Rni "$KEYWORD" /etc 2>/dev/null | head -10 | tee "$BASE_DIR/keywords_hunting.txt"
	log_action "Keyword hunt: $KEYWORD"
	echo -e "\n"
}

log_analysis () {
	echo -e "\n"
	read -p "Enter log file path:  " LOGFILE
	if [ -f "$LOGFILE" ]; then
	echo "Searching for suspicious patterns, wait: "
	RESULT=$(grep -Ei "failed|error|unauthorized|denied" "$LOGFILE")
	if [ -n "$RESULT" ]
	   then
		echo "Suspicious entries found:"
		echo "$RESULT"
	else
		echo "No suspicious activity found"
	fi

	log_action "Log analysis on $LOGFILE"
	else
	echo "Log file Not found"
	fi
	echo -e "\n"
}

backup_dir (){
        echo -e "\n"
        read -p "Enter directory to backup it: " dir
        if [ -d "$dir" ]
        then
	  if ! command -v zip >/dev/null
	     then
	        echo -e "zip command Not exists \n"
		return
	  fi
           mkdir -p $BASE_DIR/backups
           zip -r  $BASE_DIR/backups/backup_$(date +%F).zip "$dir" >/dev/null
           echo "Backup completed, sucseccfully"
           log_action "Backup time"
        else
           echo "Directory not found, Please try again"
        fi
           echo -e "\n"
}

help_menu (){
        echo "================================================================================================"
        echo "                                 Linux Red Team Utility Tool "
        echo "================================================================================================"
        echo -e "\n"
        echo " 1) System Information "
        echo " 2) Disk Usage"
        echo " 3) Memory Usage"
	echo " 4) Users Enumeration"
	echo " 5) Privileged users"
        echo " 6) Group Enumeration"
        echo " 7) Ecumeration users without password"
        echo " 8) Show Recent fiels opened"
        echo " 9) Keyword hunting"
        echo "10) check the log file "
        echo "11) Backup Directory"
        echo "12) Exit"
        echo -e "\n"

}

while true
do
        help_menu
        read -p "Choose an option: " choice

        case $choice in

           1) system_info;;
           2) disk_usage ;;
	   3) memory_usage;;
           4) enum_user;;
	   5) root_user;;
	   6) enum_group;;
	   7) enum_nopassword;;
	   8) enum_file;;
	   9) keyword_hunt;;
	  10) log_analysis;;
	  11) backup_dir;;
          12) echo "Goodbye $USER " ; break;;
           *) echo "Invalid choice, try again";;

        esac

done

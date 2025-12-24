Linux-Red-Team-Utility-Toolkit (Bash)
A beginner-to-intermediate Bash scripting project that provides a menu‑driven Linux Red Team / system reconnaissance utility toolkit using Bash functions, logging, and automation.

This project was built to practice Bash scripting, system enumeration, log analysis, and basic red team techniques in Linux environments.

🚀 Features
🖥️ System Information

Current user

Hostname

System boot time

Uptime

Kernel & OS information

💾 Disk Usage

Displays disk usage of the root filesystem

🧠 Memory Usage

Shows RAM usage in human‑readable format

👥 User Enumeration

Lists all system users

Saves output to user.txt

🔐 Privileged Users

Detects users with UID 0 (root privileges)

Saves output to root_users.txt

👨‍👩‍👧‍👦 Group Enumeration

Lists all system groups

Saves output to group.txt

🚫 Users Without Passwords

Identifies users with empty or locked passwords

Requires root privileges

Saves output to user_nopassword.txt

🕒 Recent Files Enumeration

Shows recently modified files in the home directory

Saves output to recent_file.txt

🔍 Keyword Hunting

Searches /etc for a user‑defined keyword

Saves results to keywords_hunting.txt

📄 Log File Analysis

Scans log files for suspicious keywords:

failed

error

unauthorized

denied

🗜️ Directory Backup

Compresses a selected directory into a ZIP file

Stores backups in backups/

📝 Action Logging

Logs every action with timestamp

Stored in system_toolkit.log

📋 Interactive Menu

Simple, clean, and beginner‑friendly CLI menu

#!/bin/bash

# Check for superuser privileges
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo -e "\n### System Startup Information ###\n"

# Define a function to check if a file exists and display its contents
display_file_contents() {
    if [ -f "$1" ]; then
        echo -e "\nContents of $1:"
        echo "===================="
        cat "$1"
        echo "===================="
    fi
}

# Check /etc/inittab, /etc/rc.d/rc, /etc/rc.sysinit, and /etc/rc.local files
display_file_contents "/etc/inittab"
display_file_contents "/etc/rc.d/rc"
display_file_contents "/etc/rc.sysinit"
display_file_contents "/etc/rc.local"

# Check service files
echo -e "\nService files in /etc/systemd/system:"
echo "===================="
ls -l /etc/systemd/system/*.service 2>/dev/null
echo "===================="


echo -e "\nService files in /run/systemd/system:"
echo "===================="
ls -l /run/systemd/system/*.service 2>/dev/null
echo "===================="

echo -e "\nService files in /usr/lib/systemd/system:"
echo "===================="
ls -l /usr/lib/systemd/system/*.service 2>/dev/null
echo "===================="

# Check services started within the rc.d directories and corresponding MAC times

echo -e "\nServices started within the rc.d directories and corresponding MAC times:"
echo "===================="
ls -Rlacrt /etc/rc[0-9].d 2>/dev/null
echo "===================="

# Check runlevel service configuration
if command -v chkconfig &> /dev/null
then
    echo -e "\nRunlevel service configuration:"
    echo "===================="
    chkconfig --list
    echo "===================="
fi

# Check enabled services
if command -v systemctl &> /dev/null
then
    echo -e "\nEnabled services:"
    echo "===================="
    systemctl list-unit-files --type=service | grep enabled
    echo "===================="
fi

# Check scheduled tasks
display_file_contents "/etc/crontab"
ls /etc/cron.* 2>/dev/null
display_file_contents "/etc/anacrontab"

#!/bin/bash

# Check for superuser privileges
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Get the list of users logged in
echo "========== =========="
echo "Users currently logged in:"
echo "========== =========="
w
echo " " 

echo " " 
# Get the list of all users
echo "========== =========="
echo "All users:"
echo "========== =========="
cut -d: -f1 /etc/passwd
echo " " 

echo " " 
# Get the list of all groups
echo "========== =========="
echo "All groups:"
echo "========== =========="
cut -d: -f1 /etc/group
echo " " 

echo " " 
# Check /etc/passwd, /etc/shadow, and /etc/group files
echo "========== =========="
echo "Contents of /etc/passwd:"
echo "========== =========="
cat /etc/passwd
echo " " 

echo " " 
echo "========== =========="
echo "Contents of /etc/shadow:"
echo "========== =========="
cat /etc/shadow
echo " " 

echo " " 
echo "========== =========="
echo "Contents of /etc/group:"
echo "========== =========="
cat /etc/group
echo " " 

# Check for users with shell access
echo "========== =========="
echo "Users with shell access:"
echo "========== =========="
grep -E 'bin/bash|bin/sh|bin/zsh' /etc/passwd
echo " " 

# Check .bash_history for each user
for dir in /home/*/
do
  dir=${dir%*/}
  user=${dir##*/}
  echo "========== =========="
  echo "Command history for $user:"
  echo "========== =========="
  cat /home/$user/.*_history
  echo " " 
done

# Check root user's command history
echo "========== =========="
echo "Command history for root:"
echo "========== =========="
cat /root/.*_history

#!/bin/bash
if [[ $# -eq 0 ]]; then
    echo "usage: ./wp-fixperms.sh validuser"
    exit 0
fi

if [ ! -d /home/$1 ]; then
    echo "$1 is an invalid user"
    exit 0
fi

user=$1
apache_user=apache

find /home/$user/public_html/ -exec chown $user:$user {} \;
find /home/$user/public_html/ -type d -exec chmod 755 {} \;
find /home/$user/public_html/ -type f -exec chmod 644 {} \;

chown $apache_user:$apache_user /home/$user/public_html/wp-admin/includes/file.php
chgrp $apache_user /home/$user/public_html/wp-config.php
chmod 660 /home/$user/public_html/wp-config.php

find /home/$user/public_html/wp-content -exec chgrp $apache_user {} \;
find /home/$user/public_html/wp-content -type d -exec chmod 775 {} \;
find /home/$user/public_html/wp-content -type f -exec chmod 664 {} \;

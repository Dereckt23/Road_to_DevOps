#!/bin/bash

group="release_team"

read -p "Please enter your Username: " username

if groups "$username" | grep -qw "$group"; then
	echo "Access Granted"
	cat /srv/releases/release_notes.txt
else
	echo "Access denied"
	echo "The user $username has tryied to enter a sensitive file without the required permissions at $(date)" >> /var/log/access_attempts.log

fi

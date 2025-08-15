# Challenge: The DevOps Safe

## Issue
The fictional company **CloudCorp** has a Linux server where a secret file called `release_notes.txt` is stored, containing sensitive information about the upcoming deployment.  
Only a special user called `devopslead` can access the file. However, the development team needs a script that simulates the generation of these files and a process that monitors who attempts to access them.  

Your mission is to configure the entire environment and make it work with the requested security rules.

---

## Solution

```bash
# Creating the required users, the intruder and a work area for the DevOps lead
useradd devopslead 
useradd dereck 
useradd alice 
useradd intruder
mkdir /home/devopslead

# Creating release team and adding it's members
groupadd release_team
usermod -aG release_team devopslead
usermod -aG release_team dereck
usermod -aG release_team alice

# Creating a releases directory and a release_notes.txt inside of it with its respective permissions
mkdir /srv/releases
chmod 750 /srv/releases
touch /srv/releases/release_notes.txt
chmod 640 /srv/releases/release_notes.txt

# Create a process that updates release_notes.txt every few seconds, then we need to track it and change it's priority
touch cpu_stress.sh
htop
renice -n 10 -p <process_id>

# Creating script to check access of th users
script at check_access.sh

# Configuring cron job to simulate an intruder access attempt every 2 minutes
crontab -l
crontab -e
*/2 * * * * /home/devopslead/Road_to_DevOps/Linux/check_access.sh intruder # add at the end of the file
```

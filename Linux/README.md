Challenge: The DevOps Safe

Issue:

The fictional company CloudCorp has a Linux server where a secret file called release_notes.txt is stored, containing sensitive information about the upcoming deployment.
Only a special user called devopslead can access the file.
However, the development team needs a script that simulates the generation of these files and a process that monitors who attempts to access them.
Your mission is to configure the entire environment and make it work with the requested security rules.

Solution:

1. (useradd devopslead dereck alice intruder), (mkdir /home/devopslead) # Creating the required users, the intruder and a work area for the DevOps lead.
2. (groupadd release_team), (usermod -aG release_team devopslead dereck alice) # Creating release team and adding it's members.
3. (mkdir /srv/releases), (chmod 750 /srv/releases), (touch /srv/releases/release_notes.txt), (chmod 640 /srv/releases/release_notes.txt) # Creating a releases directory and a release_notes.txt inside of it with it's respective permissions

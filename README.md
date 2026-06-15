Automated attendance tracker. 


This project automates the setup of a Student Attendance Tracker environment using a Bash shell script. The script creates the required directory structure,
copies application files, updates attendance thresholds, validates the environment, and handles interruptions safely.

HOW TO RUN THE SCRIPT

if the user want to run the script, first he/she will have to bring down the repository to the terminal he is operating on by cloning the repository 
by "gitclone ......................" then "cd" to the directory holding the script inside then type "./ setup.sh" or "bash setup.sh" whatever work then the
script will prompt the user to enter first the project name then follow all the prompts till finishing the project.



Triggering the Archive Feature

The script includes a SIGINT trap that handles user interruptions.

To test the archive feature:

Run the script:
bash setup_project.sh
Press:
Ctrl + C

while the script is executing.

The script will:
Display an interruption message.
Create an archive named:
attendance_tracker_<project_name>_archive.tar.gz
Remove the incomplete project directory.
Exit safely.

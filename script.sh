#Write a shell script that accepts file or a directory name as an argument. 
#Have the script report if it is a regular file, or a directory, or other type of file.
#If it is a regular file exit with a 0 exit status. If it is a directory, exit with a 1 exit status. 
#If it is some other type of file, exit with a 2 exit status. 

#!/bin/bash

# This will check if an argument was provided or not
if [ $# -eq 0 ]; then
  echo "****Error: Please provide a file or directory name as an argument.**** "
  exit 1
fi

# This is the argument
File=$1

# This will check if the file exist
if [ ! -e "$File" ]; then
  echo "Error: File or directory '$File' does not exist."
  exit 1
fi

# This will check the type of file provided as argument and report to us
if [ -f "$File" ]; then
  echo "Regular file: $File"
  exit 0
elif [ -d "$File" ]; then
  echo "Directory: $File"
  exit 1
else
  echo "Other type of file: $File"
  exit 2
fi 
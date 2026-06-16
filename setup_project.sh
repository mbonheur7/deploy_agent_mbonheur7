#!/bin/bash
echo "what is the project name?"
read input
project_dir="attendance_tracker_$input"
#empty input
if [ -z "$input" ]; then
    echo "Project name cannot be empty"
    exit 1
fi
#if the project already exists
if [ -d "$project_dir" ]; then
    echo "Project already exists"
    exit 1
fi
userinterruptions() {
    echo "Interrupted, archiving project..."
    tar -czf "${project_dir}_archive.tar.gz" "$project_dir"
    rm -rf "$project_dir"
    exit 1
}
trap userinterruptions SIGINT
mkdir -p "$project_dir/Helpers"
mkdir -p "$project_dir/reports"
cp attendance_checker.py "$project_dir/"
cp assets.csv "$project_dir/Helpers/"
cp config.json "$project_dir/Helpers/"
cp reports.log "$project_dir/reports/"
echo "Do you want to update the attendance thresholds? (yes/no)?"
read answer
if [ "$answer" = "yes" ]; then
    echo "Enter warning threshold:"
    read warning
    if ! [[ "$warning" =~ ^[0-9]+$ ]] || [ "$warning" -lt 0 ] || [ "$warning" -gt 100 ]; then
        echo "Please enter a number between 0 and 100"
        exit 1
    fi
    echo "Enter failure threshold:"
    read failure
    if ! [[ "$failure" =~ ^[0-9]+$ ]] || [ "$failure" -lt 0 ] || [ "$failure" -gt 100 ]; then
        echo "Please enter a number between 0 and 100"
        exit 1
    fi
    if [ "$failure" -ge "$warning" ]; then
        echo "Failure threshold must be less than warning threshold"
        exit 1
    fi
    sed -i "s/\"warning\": 75/\"warning\": $warning/" "$project_dir/Helpers/config.json"
    sed -i "s/\"failure\": 50/\"failure\": $failure/" "$project_dir/Helpers/config.json"
fi
#validatin starts here
echo "checking if Python is installed.."
if python3 --version >/dev/null 2>&1; then
     echo "python3 is installed"
else
     echo "Warning: python3 is not installed"
fi
if [ -d "$project_dir/Helpers" ] && [ -d "$project_dir/reports" ]; then
   echo "Directory structure verified"
else
   echo "Directory structure is incorrect"
fi
                   echo "Project setup completed."

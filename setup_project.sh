#!/bin/bash
echo "what is the project name"
read project_name
project_dir="attendance_tracker_$project_name"
cleanup() {
    echo "Interrupted, archiving project..."
    tar -czf "${project_dir}_archive.tar.gz" "$project_dir"
    rm -rf "$project_dir"
    exit 1
}
trap cleanup SIGINT
mkdir -p "$project_dir/Helpers"
mkdir -p "$project_dir/reports"
cp attendance_checker.py "$project_dir/"
cp assets.csv "$project_dir/Helpers/"
cp config.json "$project_dir/Helpers/"
cp reports.log "$project_dir/reports/"
echo "Do you want to update the threshold? (yes/no)?"
read answer
if [ "$answer" = "yes" ]; then
    echo "Enter warning threshold;"
    read warning
    echo "Enter failure threshold"
    read failure
    sed -i "s/\"warning\": 75/\"warning\": $warning/" "$project_dir/Helpers/config.json"
    sed -i "s/\"failure\": 50/\"failure\": $failure/" "$project_dir/Helpers/config.json"

fi

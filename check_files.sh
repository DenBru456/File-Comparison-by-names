#!/bin/bash

# Prompt the user for inputs
read -p "Enter the path to the source folder: " source_folder
read -p "Enter the path to the target folder: " target_folder
read -p "Enter the path to the log file (including file name): " log_file

# Check if the folders and log file are specified
if [ -z "$source_folder" ]; then
    echo "Source folder path cannot be empty."
    exit 1
fi

if [ -z "$target_folder" ]; then
    echo "Target folder path cannot be empty."
    exit 1
fi

if [ -z "$log_file" ]; then
    echo "Log file path cannot be empty."
    exit 1
fi

# Initialize log file
echo "Files not found in target folder:" > "$log_file"

# Recursive file search function
search_files() {
    local source_folder="$1"
    local target_folder="$2"
    local log_file="$3"

    # Iterate through each file in source folder
    find "$source_folder" -type f | while read -r file; do
        relative_path="${file#$source_folder/}"
        if [ ! -f "$target_folder/$relative_path" ]; then
            echo "$relative_path" >> "$log_file"
        fi
    done
}

# Call the recursive file search function
search_files "$source_folder" "$target_folder" "$log_file"

echo "Done. Check the log file at $log_file."

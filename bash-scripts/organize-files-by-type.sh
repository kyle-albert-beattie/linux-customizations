#!/bin/bash

# Ask user which directory to organize
echo "Which directory would you like to organize by file type?"

# Read user input
read "INPUT_DIR"

# Create a dictionary to store file types and their corresponding directories
declare -A file_types

# Iterate over all files in the input directory
for file in "$INPUT_DIR"/*; do
  # Get the file extension (e.g., .txt, .pdf, etc.)
  file_ext="${file##*.}"

  # Check if the file type is already in the dictionary
  if [[ -z "${file_types[$file_ext]}" ]]; then
    # Create a new directory for this file type
    file_types[$file_ext]=$(mkdir -p "${INPUT_DIR}/.${file_ext}" && echo "${INPUT_DIR}/.${file_ext}")
  fi

  # Move the file to its corresponding directory
  mv "$file" "${file_types[$file_ext]}"
done

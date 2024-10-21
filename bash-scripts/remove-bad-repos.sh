#!/bin/bash

# Set the directory path
REPO_DIR=/etc/apt/sources.list.d/

# Iterate through files in the directory
for file in "$REPO_DIR"/*; do
  # Check if the file is a valid repository file
  if [ -f "$file" ]; then
    # Get the repository name from the file name
    REPO_NAME=${file##*/}

    # Try to update the repository
    apt update --allow-unauthenticated --quiet --fix-missing 2>/dev/null

    # Check if the update failed (non-working repository)
    if [ $? -ne 0 ]; then
      # Remove the non-working repository file
      rm "$file"
      echo "Removed non-working repository: $REPO_NAME"
    fi
  fi
done

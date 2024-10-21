#!/bin/bash
# Description:
# This script will rename all files in the folder as their last modifcation date.

for f in *; do
  fn=$(basename "$f")
  mv "$fn" "$(date -r "$f" +"%Y-%m-%d_%H-%M-%S")_$fn"
done


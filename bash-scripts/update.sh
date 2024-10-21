#!/bin/bash -x
# This script will update and clean any left over packages
sudo apt update
sudo apt upgrade
sudo apt autoremove
sudo apt clean

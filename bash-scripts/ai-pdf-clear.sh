#!/bin/bash
# This script will clear all of the pdfs in the private-gptmemory.
find /home/kyle/private-gpt/local_data/ -mindepth 1 -exec rm {} \;

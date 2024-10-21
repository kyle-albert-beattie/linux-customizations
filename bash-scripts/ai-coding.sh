#!/bin/bash
# Dependencies: llama.cpp
# Models: mistral-7b-instruct-v0.1.Q4_0.gguf
# Description: This script will launch an instance of the mistral coding LLM.
# Coding question
echo What would you like to ask the coding AI?
read -r text
/home/kyle/llama.cpp/main -m /media/kyle/4B/LLMs/LLM-Vox/codellama-7b.Q5_K_M.gguf -c 4096 --temp 0.7 --repeat_penalty 1.1 -i -p "${text}"

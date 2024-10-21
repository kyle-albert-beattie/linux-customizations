#!/bin/bash
# Dependencies: llama.cpp
# Models: Neo-Dolphin-Mistral-7B-E4-0-1-6-Q8-June-24.gguf
# Description: This script will launch an instance of Mike Adams' LLM trained on data from NaturalNews.com
# Alternative question
echo What would you like to ask the alternative AI?
read -r text
/home/kyle/llama.cpp/main -m /media/kyle/4B/LLMs/LLM-Vox/Neo-Dolphin-Mistral-7B-E4-0-1-6-Q8-June-24.gguf -c 4096 --temp 0.7 --repeat_penalty 1.1 -i -p "${text}"

#!/bin/bash
# Dependencies: llama.cpp
# Models: Neo-Phi-2-E2-V0.1-Apr-24.gguf
# Description: This script will launch an instance of the standard LLM.
# Normal question
echo What would you like to ask the normal AI?
read -r text
/$HOME/llama.cpp/main -m /media/kyle/4B/LLMs/LLM-Vox/Meta-Llama-3.1-8B-Instruct-Q6_K.gguf -c 4096 --temp 0.7 --repeat_penalty 1.1 -i -p "${text}"

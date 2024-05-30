#!/bin/bash
# Normal question
echo What would you like to ask the normal AI?
read text
/home/kyle/llama.cpp/main -m /media/kyle/4B/LLMs/LLM-Vox/Neo-Phi-2-E2-V0.1-Apr-24.gguf -c 4096 --temp 0.7 --repeat_penalty 1.1 -i -p "${text}"







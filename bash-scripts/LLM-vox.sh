#!/bin/bash
# LLM-vox
# Author: Kyle Beattie 26-05-2022
# Dependencies: piper, llama.cpp, vosk, arecord, aplay
# Model: phi-2.Q5_K_M.gguf

# Description
# This script will allow for a voice prompt and voice response from a variety of LLMs.

# Variables
vosk_model="vosk-model-en-us-0.42-gigaspeech"
piper_model="/home/kyle/Downloads/en_US-lessac-medium.onnx"
piper="/home/kyle/Downloads/piper_amd0064/piper/piper"
#llm="/media/kyle/4B/LLMs/LLM-Vox/codellama-7b.Q5_K_M.gguf"
llm="/media/kyle/4B/LLMs/LLM-Vox/phi-2.Q5_K_M.gguf"

# This will place a notification with instructions for the user
notify-send 'Please state your prompt now.' 'You have 8 seconds'
# This will record the prompt and save it as a .wav file
arecord -V stereo -f dat --duration=8 rec.wav;
# This will transcribe the .wav file to text
request=$(vosk-transcriber --model-name $vosk_model --lang en --input rec.wav)
#request=$(omnisense transcribe --quantize rec.wav)
# This will ask the question to the specified model
/home/kyle/llama.cpp/main -m "$llm" -c 4096 --temp 0.7 --repeat_penalty 1.1 -i -p "$request" |
# This will record the LLM response as raw audio output
$piper --model $piper_model --output-raw |
# This will play the raw audio output from the LLM
aplay -r 22050 -f S16_LE -t raw
exit

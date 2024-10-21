#!/bin/bash
# Dependencies
# brew: https://docs.brew.sh/Homebrew-on-Linux
# poetry: https://python-poetry.org/docs/#installing-with-the-official-installer
# private-gpt: https://docs.privategpt.dev/

# Description:
# This script will launch the private-gpt PDF AI so you can load PDFs into an LLM and ask questions about any corpora.

cd "/$HOME/private-gpt/" || exit
# Uncomment for ollama
#PGPT_PROFILES=ollama make run
# Uncomment for local llm
PGPT_PROFILES=local make run

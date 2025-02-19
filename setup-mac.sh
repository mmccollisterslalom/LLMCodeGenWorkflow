#!/usr/bin/env bash

# Setup script for macOS/Linux
set -e  # Exit on error

# Install dependencies
echo "Installing dependencies..."
command -v brew >/dev/null 2>&1 || { echo >&2 "Homebrew not found, installing..."; /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }

brew install python3 mise
pip3 install repomix llm

# Install LLM-Ollama support
llm install llm-ollama

# Install Mistral model
echo "Downloading Mistral model..."
ollama pull mistral

# Confirm mise tasks setup
echo "Setting up mise tasks..."
mise run LLM:clean_bundles || echo "mise tasks need to be manually configured."

echo "Setup complete! Run mise tasks using 'mise run <task>'"

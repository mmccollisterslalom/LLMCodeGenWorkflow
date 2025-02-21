#!/bin/bash

# Start Mise-en-Place process in the background
echo "🚀 Starting Mise-en-Place tasks..."
mise run LLM:clean_bundles

# Start File Browser to serve files inside /app/output
echo "🌐 Starting File Browser..."
filebrowser -r /app/output --port 8080 --noauth &

# Keep the container running
tail -f /dev/null

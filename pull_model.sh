#!/bin/bash
# Allow some time for the main ollama server to start
sleep 10

MODEL_TO_PULL="nous-hermes-2-llama-3-70b"

# Check if the model is already downloaded
if ! ollama list | grep -q "$MODEL_TO_PULL"; then
  echo "--- Pulling model $MODEL_TO_PULL ---"
  ollama pull "$MODEL_TO_PULL"
else
  echo "--- Model $MODEL_TO_PULL already exists ---"
fi

# This script is designed to run once and exit.
# Supervisor will not restart it because autorestart=false.
echo "--- Model check complete. ---"

#!/bin/bash
sleep 15 # Wait a bit longer for the services to be ready

MODEL_TO_PULL="nous-hermes-2-llama-3-70b"

# Check if the model is already downloaded
if ! ollama list | grep -q "$MODEL_TO_PULL"; then
  echo "--- Pulling model $MODEL_TO_PULL ---"
  ollama pull "$MODEL_TO_PULL"
else
  echo "--- Model $MODEL_TO_PULL already exists ---"
fi

echo "--- Model check complete. ---"

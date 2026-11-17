#!/usr/bin/env bash
# Setup for Ubuntu/WSL. Core build needs only g++/make; websim needs Emscripten (CI pins 3.1.64).
set -euo pipefail
sudo apt-get update
sudo apt-get install -y build-essential make git python3 python3-venv python3-pip nodejs
python3 -m venv .venv
.venv/bin/pip install --upgrade pip
.venv/bin/pip install -r requirements.txt
make build
# Optional web build (make websim): Emscripten from the official emsdk repo (https://github.com/emscripten-core/emsdk),
# pinned to 3.1.64 as in CI. Skip with WITH_EMSDK=0 bash setup.sh.
if [ "${WITH_EMSDK:-1}" = "1" ]; then
  [ -d emsdk ] || git clone --depth 1 https://github.com/emscripten-core/emsdk.git emsdk
  ./emsdk/emsdk install 3.1.64
  ./emsdk/emsdk activate 3.1.64
  echo "Web build: source ./emsdk/emsdk_env.sh && make websim && make serve"
fi
echo "Tests: make test"

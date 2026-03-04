#!/usr/bin/env bash
set -euo pipefail

# Always run from the script's directory
cd "$(dirname "$0")"

PYTHON_BIN=${PYTHON_BIN:-python3}
VENV_DIR=${VENV_DIR:-.venv}

echo "[setup] Using Python: $PYTHON_BIN"

if [[ ! -d "$VENV_DIR" ]]; then
  echo "[setup] Creating virtualenv at $VENV_DIR"
  "$PYTHON_BIN" -m venv "$VENV_DIR"
fi

# shellcheck source=/dev/null
source "$VENV_DIR/bin/activate"

echo "[setup] Upgrading pip/setuptools/wheel"
python -m pip install --upgrade pip setuptools wheel

echo "[setup] Installing requirements"
pip install -r requirements.txt

MODE=${1:-streamlit}

if [[ "$MODE" == "python" ]]; then
  echo "[run] Running with plain Python (note: Streamlit apps should typically use 'streamlit run')"
  python app.py
else
  echo "[run] Starting Streamlit app"
  streamlit run app.py --server.headless true
fi



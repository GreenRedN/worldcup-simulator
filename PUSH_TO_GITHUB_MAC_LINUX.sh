#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

echo "===== World Cup Simulator: GitHub Push Helper (macOS/Linux) ====="

if ! command -v git >/dev/null 2>&1; then
  echo "[ERROR] Git is not installed. Install git and re-run this script." >&2
  exit 1
fi

read -r -p "Paste your GitHub repository URL (ends with .git): " REPO_URL
if [[ -z "${REPO_URL}" ]]; then
  echo "[ERROR] Repository URL is empty." >&2
  exit 1
fi

if [[ ! -d .git ]]; then
  echo "Initializing git repository..."
  git init
  git add -A
  git commit -m "Initial commit"
  git branch -M main
fi

if git remote get-url origin >/dev/null 2>&1; then
  git remote remove origin
fi

git remote add origin "${REPO_URL}"

echo "Pushing to GitHub..."
git push -u origin main

echo "Done."

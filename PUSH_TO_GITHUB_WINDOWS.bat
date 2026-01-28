@echo off
setlocal enabledelayedexpansion
cd /d %~dp0

echo.
echo ===== World Cup Simulator: GitHub Push Helper (Windows) =====
echo This will push the entire project (including src/) to your GitHub repository.
echo.

where git >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Git is not installed or not in PATH.
  echo Install Git for Windows, then re-run this file.
  pause
  exit /b 1
)

set "REPO_URL="
set /p REPO_URL=Paste your GitHub repository URL (ends with .git): 
if "%REPO_URL%"=="" (
  echo [ERROR] Repository URL is empty.
  pause
  exit /b 1
)

if not exist ".git" (
  echo Initializing git repository...
  git init
  git add -A
  git commit -m "Initial commit"
  git branch -M main
)

echo Setting remote "origin"...
for /f "delims=" %%r in ('git remote') do (
  if "%%r"=="origin" (
    git remote remove origin
  )
)

git remote add origin "%REPO_URL%"

echo Pushing to GitHub...
git push -u origin main

echo.
echo Done.
echo If you got an authentication error, sign in to GitHub Desktop or run:
echo   git config --global credential.helper manager
pause

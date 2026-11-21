@echo off
cd /d "%~dp0"
python app.py
if errorlevel 1 (
  echo.
  echo Could not start with python. Try: py app.py
  pause
)

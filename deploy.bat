@echo off
REM Deployment script for R&D Proposal Evaluation System (Windows)

echo Starting deployment of R&D Proposal Evaluation System...

REM Check if we're in the right directory
if not exist "core\app_hil.py" (
    echo Error: This script must be run from the project root directory
    exit /b 1
)

REM Create a virtual environment (optional but recommended)
echo Creating virtual environment...
python -m venv venv

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate

REM Install dependencies
echo Installing dependencies...
python -m pip install --upgrade pip
pip install -r docs/requirements.txt

REM Create necessary directories and files if they don't exist
echo Setting up environment...
if not exist "data" mkdir data
if not exist "outputs" mkdir outputs

REM Run any initialization scripts
if exist "core\create_sample_data.py" (
    echo Creating sample data...
    python core\create_sample_data.py
)

echo Deployment completed successfully!
echo.
echo To run the application:
echo 1. Activate the virtual environment: call venv\Scripts\activate
echo 2. Run the Streamlit app: streamlit run core/app_hil.py
echo.
echo The application will be available at http://localhost:8501
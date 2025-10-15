#!/bin/bash

# Deployment script for R&D Proposal Evaluation System

# Exit on any error
set -e

echo "Starting deployment of R&D Proposal Evaluation System..."

# Check if we're in the right directory
if [ ! -f "core/app_hil.py" ]; then
    echo "Error: This script must be run from the project root directory"
    exit 1
fi

# Create a virtual environment (optional but recommended)
echo "Creating virtual environment..."
python -m venv venv

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate  # For Linux/Mac
# For Windows, use: venv\Scripts\activate

# Install dependencies
echo "Installing dependencies..."
pip install --upgrade pip
pip install -r docs/requirements.txt

# Create necessary directories and files if they don't exist
echo "Setting up environment..."
mkdir -p data
mkdir -p outputs

# Run any initialization scripts
if [ -f "core/create_sample_data.py" ]; then
    echo "Creating sample data..."
    python core/create_sample_data.py
fi

echo "Deployment completed successfully!"
echo ""
echo "To run the application:"
echo "1. Activate the virtual environment: source venv/bin/activate"
echo "2. Run the Streamlit app: streamlit run core/app_hil.py"
echo ""
echo "The application will be available at http://localhost:8501"
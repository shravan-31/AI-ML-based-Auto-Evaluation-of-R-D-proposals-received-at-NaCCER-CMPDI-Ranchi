# Deployment Instructions

This document provides instructions for deploying the R&D Proposal Evaluation System.

## Prerequisites

- Python 3.7 or higher
- pip (Python package manager)
- Git (optional, for cloning the repository)

## Deployment Options

### 1. Streamlit Cloud Deployment

1. Push your code to a GitHub repository
2. Go to [Streamlit Cloud](https://share.streamlit.io/)
3. Connect your GitHub repository
4. Select the `core/app_hil.py` file as the entry point
5. Streamlit Cloud will automatically detect and install dependencies from `docs/requirements.txt`

### 2. Docker Deployment

#### Using Docker Compose (Recommended)

```bash
# Navigate to the docs directory
cd docs

# Build and run the containers
docker-compose up --build
```

The application will be available at:
- Streamlit UI: http://localhost:8501
- API (if applicable): http://localhost:5000

#### Using Docker Directly

```bash
# From the project root directory
docker build -t rdp-evaluator -f docs/Dockerfile .

# Run the container
docker run -p 8501:8501 -p 5000:5000 rdp-evaluator
```

### 3. Manual Deployment

#### On Linux/Mac:

```bash
# Make the deployment script executable
chmod +x deploy.sh

# Run the deployment script
./deploy.sh
```

#### On Windows:

```cmd
# Run the deployment script
deploy.bat
```

### 4. Direct Installation

```bash
# Install dependencies
pip install -r docs/requirements.txt

# Run the application
streamlit run core/app_hil.py
```

## Environment Variables

The application may require the following environment variables:

- `PYTHONUNBUFFERED=1` (set in docker-compose.yml)

## Troubleshooting

### Missing Dependencies

If you encounter `ModuleNotFoundError` errors:

1. Ensure all dependencies are installed:
   ```bash
   pip install -r docs/requirements.txt
   ```

2. If using Docker, make sure the Dockerfile is correctly referencing the requirements file.

### Port Conflicts

If ports 8501 or 5000 are already in use:

1. Modify the ports in `docker-compose.yml`
2. Or run the application with different ports:
   ```bash
   streamlit run core/app_hil.py --server.port=8502
   ```

## Updating the Application

To update the application:

1. Pull the latest code from the repository
2. Rebuild the Docker containers (if using Docker):
   ```bash
   docker-compose up --build
   ```
3. Or reinstall dependencies (for manual deployment):
   ```bash
   pip install -r docs/requirements.txt --upgrade
   ```
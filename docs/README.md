# R&D Proposal Evaluation System

An AI/ML system to automatically evaluate R&D proposals based on novelty, funding requirements, technical feasibility, and coal industry relevance.

## Features

1. **Novelty Scoring**: Uses Sentence-BERT embeddings to compute semantic similarity between new proposals and past proposals
2. **Funding Scoring**: Normalizes funding requests and gives higher scores to lower funding proposals
3. **Feasibility Scoring**: (Optional) Evaluates technical feasibility based on keyword matching
4. **Coal Relevance Scoring**: Evaluates relevance to coal industry based on domain-specific keyword matching
5. **Weighted Evaluation**: Combines scores using configurable weights
6. **Ranking**: Ranks proposals by their final evaluation score
7. **Web Interface**: Streamlit-based UI for easy interaction
8. **Export Results**: Generates CSV reports of evaluated proposals

## Installation

1. Clone or download this repository
2. Install the required packages:
   ```bash
   pip install -r docs/requirements.txt
   ```

## Usage

### Command Line Interface

Run the evaluation script directly:
```bash
python core/enhanced_evaluator.py
```

To use with your own data:
1. Prepare two CSV files:
   - `past_proposals.csv`: Contains historical proposals with columns [Proposal_ID, Title, Abstract, Funding_Requested]
   - `new_proposals.csv`: Contains proposals to evaluate with the same columns
2. Modify the `main()` function in `core/enhanced_evaluator.py` to use your file paths
3. Run the script

### Web Interface

Launch the Streamlit web app:
```bash
streamlit run core/app_hil.py
```

In the web interface, you can:
- Upload your own CSV files or use sample data
- Configure scoring weights
- Enable/disable feasibility scoring
- View ranked proposals
- Download results as CSV
- Visualize score distributions

## Deployment

### Streamlit Cloud Deployment

1. Push your code to a GitHub repository
2. Go to [Streamlit Cloud](https://share.streamlit.io/)
3. Connect your GitHub repository
4. Select the `core/app_hil.py` file as the entry point
5. Streamlit Cloud will automatically detect and install dependencies from `docs/requirements.txt`

### Docker Deployment

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

### Manual Deployment

```bash
# Install dependencies
pip install -r docs/requirements.txt

# Run the application
streamlit run core/app_hil.py
```

## How It Works

### Novelty Score
- Uses Sentence-BERT (`all-MiniLM-L6-v2`) to generate embeddings for proposal abstracts
- Computes cosine similarity between new proposals and all past proposals
- Novelty score = 1 - maximum similarity (higher means more novel)

### Funding Score
- Normalizes all funding requests using Min-Max scaling
- Inverts the normalized value so lower funding gets higher scores
- Funding score = 1 - normalized_funding

### Feasibility Score (Optional)
- Counts matches of technical keywords in proposal title and abstract
- Normalizes by total number of keywords
- Keywords include: algorithm, data, model, framework, platform, etc.

### Coal Relevance Score
- Counts matches of coal industry specific keywords in proposal title and abstract
- Normalizes by total number of coal keywords
- Keywords include: coal, mining, extraction, safety, ventilation, gas, etc.

### Final Evaluation Score
Default weighting (with feasibility scoring enabled):
- Novelty: 40%
- Funding: 20%
- Feasibility: 20%
- Coal Relevance: 20%

With feasibility scoring disabled:
- Novelty: 50%
- Funding: 25%
- Coal Relevance: 25%

Weights can be adjusted in the web interface.

## File Structure

- `core/`: Main application logic
- `models/`: Individual model components
- `utils/`: Utility functions and helpers
- `docs/requirements.txt`: Python package dependencies
- `sample_past_proposals.csv`: Example historical proposals
- `sample_new_proposals.csv`: Example proposals to evaluate

## Dependencies

- pandas: Data manipulation
- numpy: Numerical computations
- scikit-learn: Machine learning utilities
- sentence-transformers: Semantic embeddings
- nltk: Natural language processing
- streamlit: Web interface

## Sample Data Format

CSV files should have the following columns:
```
Proposal_ID,Title,Abstract,Funding_Requested
P001,"Machine Learning for Image Recognition","This project focuses on developing advanced machine learning algorithms...",50000
```

## Customization

You can customize:
1. Technical keywords for feasibility scoring (modify `technical_keywords` in `EnhancedRDPEvaluatorHIL` class)
2. Coal industry keywords for relevance scoring (modify `calculate_coal_relevance_score` method)
3. Weighting scheme (adjust weights in web interface or modify default values)
4. Sentence transformer model (change model name in `EnhancedRDPEvaluatorHIL.__init__`)
5. Text preprocessing steps (modify `preprocess_text` method)

## License

This project is open source and available under the MIT License.
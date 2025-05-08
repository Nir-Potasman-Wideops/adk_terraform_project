from google.adk.tools import google_search
from google.adk.agents import LlmAgent
from google.genai import (
    types,
)  # For config objects, though ADK might handle some implicitly

from dotenv import load_dotenv
import os

load_dotenv()  # This will load the environment variables set in your .env file

# Ensure environment variables are loaded and accessible
project_id = os.getenv("GOOGLE_CLOUD_PROJECT")
location = os.getenv("GOOGLE_CLOUD_LOCATION")
use_vertex_ai = os.getenv("GOOGLE_GENAI_USE_VERTEXAI")
model_name = os.getenv("VERTEXAI_MODEL")  # Or your desired Gemini model

# ========== Configuration for Vertex AI ==========
# Check if the required environment variables are set
if not all([project_id, location, use_vertex_ai]):
    raise ValueError(
        "Missing required environment variables for Vertex AI configuration."
    )
if use_vertex_ai.lower() != "true":
    raise ValueError(
        "GOOGLE_GENAI_USE_VERTEXAI must be set to TRUE for Vertex AI integration."
    )
# ========== End of Configuration for Vertex AI ==========

# Create a Vertex AI-based agent using ADK
root_agent = LlmAgent(
    model=model_name,
    name="helpful_assistant",
    instruction="You are a helpful Gemini assistant on Vertex AI. Answer the user's questions to the best of your ability. If you don't know the answer, please search the web.",
    tools=[google_search],
    generate_content_config=types.GenerationConfig(  # Use GenerationConfig from google.genai.types
        max_output_tokens=2048,
    ),
)

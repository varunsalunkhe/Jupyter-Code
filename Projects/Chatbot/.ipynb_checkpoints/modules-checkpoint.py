#modules
from langchain_community.document_loaders import UnstructuredFileLoader
from langchain_community.document_loaders import PyPDFLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.llms import CTransformers
import faiss
import chromadb
from langchain.vectorstores import FAISS, Chroma
import tempfile

def load_pdf(uploaded_file):
    # Create a temporary file
    with tempfile.NamedTemporaryFile(delete=False, suffix=".pdf") as temp_file:
        temp_file.write(uploaded_file.getvalue())  # Write the file content
        temp_file_path = temp_file.name  # Get the temp file path
        
    # Now load the PDF using the temp file path
    loader = PyPDFLoader(temp_file_path, extract_images=True)
    return loader.load()

def split_text(content, chunk_size=1000, chunk_overlap=200):
    """
    Splits the extracted PDF content into smaller chunks.
    """
    text_splitter = RecursiveCharacterTextSplitter(separators = ["\n\n","\n"," "],chunk_size=chunk_size, chunk_overlap=chunk_overlap)
    return text_splitter.split_documents(content)

def generate_embeddings():
    """
    Generates embeddings for the given text using Hugging Face model.
    """
    model_name="sentence-transformers/all-MiniLM-L6-v2"
    embeddings = HuggingFaceEmbeddings(model_name=model_name)
    return embeddings

def save_to_vectordb(docs, embeddings):
    """
    Saves the vectorized documents to Weaviate vector database.
    """
    vector_db = Chroma.from_documents(
        docs,
        embeddings
    )
    return vector_db

# Function to initialize the HuggingFace model
def create_huggingface_model(temperature: float = 0, context_length: int = 4096, max_new_tokens= 2048):

    try:
        llm = CTransformers(model='TheBloke/Llama-2-7B-Chat-GGML',
                      model_type='llama',
                      config={'max_new_tokens': max_new_tokens,
                              'temperature': temperature,
                              'context_length': context_length}
                      )

        return llm
    except Exception as e:
        print(f"Error in creating model: {e}")
        return None
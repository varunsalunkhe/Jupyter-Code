import os
import streamlit as st
import chromadb
from langchain.vectorstores import FAISS, Chroma
from langchain.prompts import ChatPromptTemplate 
from langchain import HuggingFaceHub
from langchain.chains import RetrievalQA, RetrievalQAWithSourcesChain, ConversationalRetrievalChain
from modules import load_pdf, split_text, generate_embeddings, save_to_vectordb,create_huggingface_model


# Streamlit interface for uploading PDF
st.title("RAG-Based Chat Bot 🤖")
uploaded_file = st.file_uploader("Upload a PDF", type=["pdf"])
main_placeholder = st.empty()

if uploaded_file is not None:
    # Step 1: Load PDF content
    pdf_content = load_pdf(uploaded_file)
    main_placeholder.write("PDF loaded successfully!")
    
    # Step 2: Split the text into chunks
    documents = split_text(pdf_content)
    # st.write(f"Text split into {len(documents)} chunks.")
    
    # Step 3: Generate embeddings for the documents
    embeddings = generate_embeddings()  # Pass documents to the function
    # st.write("Embeddings generated for the documents.")

    # Step 4: Save the vectorized documents to Weaviate
    vector_db = save_to_vectordb(documents, embeddings)
    # st.success("Documents are vectorized and saved to CromaDB.")
    
    # Step 5: Create the HuggingFace model
    # st.write("Attempting to create the HuggingFace model...")
    model = create_huggingface_model()
    # st.success("Model created successfully!")

    

    retriever = vector_db.as_retriever()
    template = """
    You are an assistant for question-answering tasks.
    Use pieces of retrieved context and provide enhanced answer to the question.
    If there is no context,just respond with: 'Sorry, I didn’t understand your question. Would you like to connect with a live agent?'
    Question: {question}
    Context: {context}
    Answer:
    """
    
    prompt = ChatPromptTemplate.from_template(template)
    
   # Defining a QnA chain
    QnA = RetrievalQA.from_chain_type(llm = model,
                                chain_type = 'stuff',
                                retriever = retriever,
                                verbose = False)
    
    # st.success("RAG pipeline created successfully!")
    
    # User Input for Questions
    question = st.text_input("Ask a question")

    def get_answers(QnA, query):
        response = QnA.run(query)
        return response
        # if "Answer:" in response:
        #     answer = response.split("Answer:", 1)[1].strip()
        #     return answer

    if question:
        with st.spinner("Processing your question..."):
            answer = get_answers(QnA, question)
            # st.write("### Answer:")
            st.write(answer)

else:
    st.warning("Please upload a PDF file to proceed.")

import os
import pickle
import streamlit as st
import time
from langchain import OpenAI
from langchain.vectorstores import FAISS
from langchain.embeddings import OpenAIEmbeddings
from langchain.document_loaders import UnstructuredURLLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.chains import RetrievalQAWithSourcesChain

from dotenv import load_dotenv
load_dotenv()

st.title("NEWS RESEARCH TOOL")

urls = []
for i in range(1):
    url = st.text_input(f"Article URL {i+1}")
    urls.append(url)

# st.write(urls)
clicked_button = st.button('SUBMIT')

llm = OpenAI(temperature = 0.9, max_tokens = 500)
main_placeholder = st.empty()
file_path = "vectorstore.pkl"

if clicked_button:
    loader = UnstructuredURLLoader(urls = urls)
    main_placeholder.text("Data Processing.........")
    docs = loader.load()

    text_split = RecursiveCharacterTextSplitter(separators = ["/n/n","/n","."," "], chunk_size = 1000)
    chunk_docs = text_split.split_documents(docs)

    embedding = OpenAIEmbeddings()
    vectorstore = FAISS.from_documents(chunk_docs, embedding)

    time.sleep(2)
    
    with open(file_path,"wb") as f:
        pickle.dump(vectorstore, f)

querry = main_placeholder.text_input("Question....")

if os.path.exists(file_path):
    with open(file_path,"rb") as f:
        vectorstore = pickle.load( f)
        ques = RetrievalQAWithSourcesChain.from_llm(llm = llm, retriever=vectorstore.as_retriever())
        result = ques({"question": querry}, return_only_outputs=True)

        st.subheader("Answer......")
        st.write(result["answer"])






import streamlit as st
from database import add_data


def create():
    col1, col2 = st.columns(2)
    with col1:
        train_number = st.text_input("Train_no:")
        train_name = st.text_input("Name:")
        train_type = st.text_input("Train_Type:")
    with col2:
        Source = st.text_input("Source:")
        Destination = st.text_input("Destination:")
        Availability = st.selectbox("Availability", ["Yes", "No"])
    if st.button("Add Train"):
        add_data(train_number, train_name, train_type,
                 Source, Destination, Availability)
        st.success("Successfully added Train: {}".format(train_number))

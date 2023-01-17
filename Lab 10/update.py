import pandas as pd
import streamlit as st
from database import view_all_data, view_only_train_names, get_train, edit_train_data


def update():
    result = view_all_data()
    df = pd.DataFrame(result, columns=[
                      'Train_number', 'Name', 'Type', 'Source', 'Destination', 'Avaiability'])
    with st.expander("Current Trains"):
        st.dataframe(df)
    list_of_trains = [i[0] for i in view_only_train_names()]
    selected_train = st.selectbox("Trains to Edit", list_of_trains)
    selected_result = get_train(selected_train)
    if selected_result:
        train_number = selected_result[0][0]
        train_name = selected_result[0][1]
        train_type = selected_result[0][2]
        Source = selected_result[0][3]
        Destination = selected_result[0][4]
        Availability = selected_result[0][5]
        col1, col2 = st.columns(2)
        with col1:
            new_train_number = st.text_input("Train_no:", train_number)
            new_train_name = st.text_input("Name:", train_name)
            new_train_type = st.text_input("Type:", train_type)
        with col2:
            new_Source = st.text_input("Source:", Source)
            new_Destination = st.text_input("Destination:", Destination)
            new_Availability = st.selectbox("Availability", ["Yes", "No"])
    if st.button("Update Train"):
        edit_train_data(train_number, new_train_name, new_train_type, new_Source, new_Destination,
                        new_Availability, train_number, train_name, train_type, Source, Destination, Availability)
        st.success("Successfully updated:: {} to ::{}".format(
            train_name, new_train_name))
    result2 = view_all_data()
    df2 = pd.DataFrame(result2, columns=[
                       'Train_number', 'Name', 'Type', 'Source', 'Destination', 'Availability'])
    with st.expander("Updated data"):
        st.dataframe(df2)

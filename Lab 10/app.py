# import mysql.connector
# mydb = mysql.connector.connect(
#     host="localhost",
#     user="root",
#     password="sneilium",
#     auth_plugin='mysql_native_password',
# )
# c = mydb.cursor()
# c.execute("CREATE DATABASE PES1UG20CS462_railway_reservation")

import streamlit as st
from create import create
from database import create_table
from delete import delete
from read import read
from update import update

def main():
    st.title("PES1UG20CS462 - Railway Reservation App")
    menu = ["Add", "View", "Edit", "Remove"]
    choice = st.sidebar.selectbox("Menu", menu)
    create_table()
    if choice == "Add":
        st.subheader("Enter Train Details:")
        create()
    elif choice == "View":
        st.subheader("View created tasks")
        read()
    elif choice == "Edit":
        st.subheader("Update created tasks")
        update()
    elif choice == "Remove":
        st.subheader("Delete created tasks")
        delete()
    else:
        st.subheader("About tasks")

if __name__ == '__main__':
    main()

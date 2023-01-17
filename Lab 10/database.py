import mysql.connector
mydb = mysql.connector.connect(
    host="localhost", user="root", password="sneilium", database="PES1UG20CS462_railway_reservation"
)
c = mydb.cursor()


def create_table():
    c.execute('CREATE TABLE IF NOT EXISTS Train(train_number TEXT, train_name TEXT, Type TEXT, Source TEXT, Destination TEXT, Avaiability TEXT)')


def add_data(train_number, train_name, train_type, Source, Destination, Availability):
    c.execute('INSERT INTO Train(train_number, train_name, Type, Source, Destination,Avaiability) VALUES (%s,%s,%s,%s,%s,%s)',
              (train_number, train_name, train_type, Source, Destination, Availability))
    mydb.commit()


def view_all_data():
    c.execute('SELECT * FROM Train')
    data = c.fetchall()
    return data


def view_only_train_names():
    c.execute('SELECT train_name FROM Train')
    data = c.fetchall()
    return data


def get_train(train_name):
    c.execute('SELECT * FROM Train WHERE train_name="{}"'.format(train_name))
    data = c.fetchall()
    return data


def edit_train_data(new_train_number, new_train_name, new_train_type, new_Source, new_Destination, new_Availability, train_number, train_name, train_type, Source, Destination, Availability):
    c.execute("UPDATE Train SET train_number=%s , train_name=%s , Type=%s , Source=%s , Destination=%s , Avaiability=%s WHERE train_number=%s and train_name=%s and Type=%s and Source=%s and Destination=%s and Avaiability=%s",
              (new_train_number, new_train_name, new_train_type, new_Source, new_Destination, new_Availability, train_number, train_name, train_type, Source, Destination, Availability))
    mydb.commit()
    data = c.fetchall()
    return data


def delete_data(train_name):
    c.execute('DELETE FROM Train WHERE train_name="{}"'.format(train_name))
    mydb.commit()

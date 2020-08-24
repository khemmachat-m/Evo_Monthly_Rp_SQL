# -*- coding: utf-8 -*-
"""
Spyder Editor

Created on Tue May 12 23:39:18 2020

@author: khemmachat
"""

datafile_Read =  '/Volumes/My Passport/SD Card/JLL Work/Project/JOB138 (JLL 19)/138-02 (CmdCenter)/Code/Python/Data/FYI Center.csv'
datafile_Write = '/Volumes/My Passport/SD Card/JLL Work/Project/JOB138 (JLL 19)/138-02 (CmdCenter)/Code/Python/Data/test.csv'

database_file = '/Volumes/My Passport/SD Card/JLL Work/Project/JOB138 (JLL 19)/138-02 (CmdCenter)/Code/Test.db'

import os
import os.path

import pandas as pd
import sqlite3
from sqlite3 import Error
#import numpy as np

### Prepare data

# Replace Building Name with Blank
fin = open(datafile_Read,'r+')
dat = fin.read()
dat = dat.replace('FYI Center BLD','') # VAV
#dat = dat.replace('FYI Center CPMS-','') # CPMS
#dat = dat.replace('FYI Center AHU ','') # AHU
dat = dat.replace('+07:00 Bangkok','')
fin.close()
fin = open(datafile_Read,'w')
fin.write(dat)
fin.close()

#Sort Column by Equipment Name
dat = pd.read_csv(datafile_Read)
df = pd.DataFrame(dat)
df.sort_index(axis=1,inplace=True)


"""
#No of Row, and Col
Count_Row = df.shape[0] #Row Count
Count_Col = df.shape[1] #Col Count
print("Row = ", Count_Row, " Col = ", Count_Col)
"""

#Change data format from column base to row
#ColOut = ts + ',' + ColName + ',' + ColData.astype(str)
#ColOut = pd.DataFrame(df, columns=['ts','1_4VAV_4_40 SupFlow L/s'])

# Column No. 0
ts = df['ts']
ColData = df.iloc[:,0] # assign data to ColData
PointName = df.columns[0] # assign name of Column to ColName
ColPointName = ColData.copy() # copy column for using as Point Name Column

ColOut = pd.concat([ts, ColData, ColPointName], axis = 1)
ColOut.columns=['ts','data','EqNoPoint']
ColOut.iloc[:,2] = PointName


# Column No. 1 till End
count = 1
for col in df.columns:
    if col not in ('ts', 'Bangkok, Thailand Temp °C'):
        print(count)
        ColData = df.iloc[:,count] # assign data to ColData
        PointName = df.columns[count] # assign name of Column to ColName
        ColPointName = ColData.copy() # copy column for using as Point Name Column
        ColOut_Temp = pd.concat([ts, ColData, ColPointName], axis = 1)
        ColOut_Temp.columns = ['ts','data','EqNoPoint']
        ColOut_Temp.iloc[:,2] = PointName
        ColOut = ColOut.append(ColOut_Temp, ignore_index = True)
        count = count + 1

ColEqNo_Point = ColOut.iloc[:,2]
ColEqNo_Point = ColEqNo_Point.str.split(" ", 1, expand=True)
ColEqNo_Point.columns = ['EqNo', 'Point']
ColOut = pd.concat([ColOut,ColEqNo_Point], axis = 1)
ColOut = ColOut.drop(['EqNoPoint'], axis = 1)

ColOut.to_csv(datafile_Write, index = False)

### Prepare DB file

# Delete existing database file.
# Check Is database file existed?
if (os.path.isfile(database_file)):
    print("database file is existed")
    # remove existing database file.
    os.remove(database_file)
    print("remove database file")

# Create blank database
conn = None
try:
    conn = sqlite3.connect(database_file)
    print("Create new blank database file already")
except sqlite3.Error as Err:
    print(Err)
finally:
    if (conn):
        conn.close()


### SQLITE

#Connect to exsiting SQLITE database
#if database is locked, delete test.db and create the new blank database without table or field.
conn = sqlite3.connect(database_file)

#Write data from CSV file into database
df = pd.read_csv(datafile_Write)
df.to_sql('test', conn, if_exists='replace', index = False)

#pd.read_sql_query("DELETE FROM test WHERE data is NULL", conn)

#Save the change and close the database
conn.commit()
conn.close()




# Modified test.db by add Hrs Column and fill in the data
try:
    #Connect to SQLITE database
    conn = sqlite3.connect(database_file)
    cursor = conn.cursor()
    print("Connected to SQLITE")

    #Delete Rows
    sql_query = """DELETE FROM test WHERE data is NULL"""
    cursor.execute(sql_query)
    conn.commit()
    print("Delete records already")

    #Add Hrs Column
    sql_query = """ALTER TABLE test ADD Hrs TEXT"""
    cursor.execute(sql_query)
    conn.commit()
    print("Add Hrs Column already")

    #Add data to Hrs Column
    sql_query = """INSERT INTO test SELECT ts, data, EqNo, Point, strftime('%Y-%m-%d %H',ts) as Hrs FROM test"""
    cursor.execute(sql_query)
    conn.commit()
    print("Add data to Hrs already")

    #Delete records that Hrs is NULL
    sql_query = """DELETE FROM test WHERE Hrs is NULL"""
    cursor.execute(sql_query)
    conn.commit()
    print("Delete records that Hrs is NULL already")

    cursor.close()

except sqlite3.Error as Err:
    print("Fail to comply")

finally:
    if (conn):
        conn.close()
        print("Close SQLITE connection")


















"""
# SQLITE

import sqlite3

conn = sqlite3.connect(database_file)

c = conn.cursor()
c.execute("SELECT *, datetime(ts) as DT	FROM test WHERE data is not NULL")
print(c)
"""

"""
#print(df.columns[0])
#print(df.iloc[:,43] + df.astype(str).iloc[:,1])
d1 = df.iloc[:,43]
d2 = df.iloc[:,2].astype(str)
#d2 = d2.astype(str)
d3 = d1 + ',' + d2
#print(d3)
d3.to_csv(datafile_Write)
"""





#d = {'col1': ["123", "234"], 'col2': ["345", "456"]}
#df = pd.DataFrame(d)

#df['col1'] = df['col1'].str.replace('1','9',regex=True)
#df['col1'] = df['col1'].replace('1','9',regex=True)
#df = df.replace('4','9',regex=True)
#df.replace({'4':'9'}, regex=True) # This don't work!

"""
d = {'col1': ["abc def", "bcd fgh"], 'col2': ["efg hij", "fgh jkl"]}
df = pd.DataFrame(d)
df = df.replace('abc def','x',regex=True)
"""

#print(df)

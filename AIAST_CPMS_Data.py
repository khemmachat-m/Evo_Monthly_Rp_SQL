
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Aug 29 10:04:30 2020

@author: khemmachat
"""

datafile_Name = 'AIA_CPMS_Data.csv'

datafolder_Read = '/Volumes/My Passport/SD Card/JLL Work/Project/JOB138 (JLL 19)/138-02 (CmdCenter)/AIAST/TIE Data/TIE_data'

datafile_Read =  '/Volumes/My Passport/SD Card/JLL Work/Project/JOB138 (JLL 19)/138-02 (CmdCenter)/AIAST/TIE Data/TIE_data/' + datafile_Name
datafile_Write = '/Volumes/My Passport/SD Card/JLL Work/Project/JOB138 (JLL 19)/138-02 (CmdCenter)/AIAST/TIE Data/TIE_data/' + datafile_Name

database_file = '/Volumes/My Passport/SD Card/JLL Work/Project/JOB138 (JLL 19)/138-02 (CmdCenter)/Code/AIAST_CPMS.db'

import os
import glob
import pandas as pd

# Set Folder for reading the file
os.chdir(datafolder_Read)

extension = 'csv'
all_filenames = [i for i in glob.glob('*.{}'.format(extension))]
print("Read file name already")

#combine all files in the list
combined_csv = pd.concat([pd.read_csv(f) for f in all_filenames ])
print("Combine all files to a file")

#export to csv
combined_csv.to_csv(datafile_Name, index=False, encoding='utf-8-sig')
print("Combine all CSV files in folder to one file already")


--------------------------------

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Aug 29 10:51:04 2020

@author: khemmachat
"""

datafile_Name = 'AIA_CPMS_Data.csv'

datafile_Read =  '/Volumes/My Passport/SD Card/JLL Work/Project/JOB138 (JLL 19)/138-02 (CmdCenter)/AIAST/TIE Data/TIE_data/' + datafile_Name
datafile_Write = '/Volumes/My Passport/SD Card/JLL Work/Project/JOB138 (JLL 19)/138-02 (CmdCenter)/AIAST/TIE Data/TIE_data/' + datafile_Name

database_file = '/Volumes/My Passport/SD Card/JLL Work/Project/JOB138 (JLL 19)/138-02 (CmdCenter)/Code/AIAST_CPMS.db'

#import os
#import os.path
import pandas as pd
import numpy as np
import sqlite3


# Upload, Replace unnecessory Text, and Rewrite into the same file name
fin = open(datafile_Read,'r+')
dat = fin.read()

dat = dat.replace('.Trend - Present Value (Trend1)','')

fin.close()
fin = open(datafile_Read,'w')
fin.write(dat)
fin.close()
print("Download File already")

# Upload data and Duplicate Column
dat = pd.read_csv(datafile_Read)
df = pd.DataFrame(dat)
print("Upload Data already")

# Remove Space from Column Header Name
df.columns = df.columns.str.replace(' ', '')
df.columns = df.columns.str.replace('/', '')
print("Remove space from header's name already")

# Replace Space with - in ObjectName
df['ObjectName'] = df.ObjectName.str.replace(' ', '-')
print("Replace Space with Dash")

# Add 20 before DateTime to make YY/MM/DD to 20YY/MM/DD
df['DateTime'] = '20' + df['DateTime'].astype(str)
print("Add Prefix '20' before Year YY")


# Split Date/Time to Date Column and Time Column
df_temp = df.DateTime.str.split(n = 1, expand = True)
df_temp.columns = ['Date', 'Time']
df = pd.concat([df, df_temp], axis = 1, sort = False)
print("Split date/time column already")


# Create EqNo Column
df['EqNo'] = df['NamePathReference'] # Duplicate Column
print("Create EqNo Column already")

# Define Equipment Number by using specific text in NamePathReference
# Replace entire value when found a
df['EqNo'] = df.EqNo.str.replace(r'(^.*5007.*$)', 'CH01')
df['EqNo'] = df.EqNo.str.replace(r'(^.*5008.*$)', 'CH02')
df['EqNo'] = df.EqNo.str.replace(r'(^.*5009.*$)', 'CH03')
df['EqNo'] = df.EqNo.str.replace(r'(^.*YR SV 1.*$)', 'CH04')
df['EqNo'] = df.EqNo.str.replace(r'(^.*YR SV 2.*$)', 'CH05')
df['EqNo'][~df.EqNo.str.contains('CH0')] = 'CPMS'
print("Assigned Equipment Number already")


# Split Value and Unit from ObjectValue Column
df_temp = df.ObjectValue.str.split(n = 1, expand = True)
df_temp.columns = ['Value', 'Unit']
df = pd.concat([df,df_temp], axis = 1, sort = False)
print("Split Value and Unit already")

# Drop unnessory column
df.drop(['Unnamed:5', 'Status', 'NamePathReference', 'ObjectValue'], axis = 1, inplace = True)

# Reorder the column
df = df.reindex(columns = ['DateTime', 'Date', 'Time', 'EqNo', 'ObjectName', 'Value', 'Unit'])

# Write the data to CSV file
df.to_csv(datafile_Write, index = False)
print("Write to CSV File")


### SQLITE ####

#Connect to exsiting SQLITE database
#if database is locked, delete test.db and create the new blank database without table or field.
conn = sqlite3.connect(database_file)

#Write data from CSV file into database
df = pd.read_csv(datafile_Write)
df.to_sql('CPMS', conn, if_exists='replace', index = False)

#Save the change and close the database
conn.commit()
conn.close()

print("Open and Write data to Database already")

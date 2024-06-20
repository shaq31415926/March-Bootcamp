import boto3
import pandas as pd
from io import StringIO

def identify_missing_data(df):
    """
    This function is used to identify missing data
    
    @param df pandas DataFrame
    
    @return a DataFrame with the percentage of missing data for every feature and the data types
    """
    
    percent_missing = df.isnull().mean()
    
    missing_value_df = pd.DataFrame(percent_missing).reset_index() # convert to DataFrame
    missing_value_df = missing_value_df.rename(columns = {"index" : "variable",
                                                                0 : "percent_missing"}) # rename columns

    missing_value_df = missing_value_df.sort_values(by = ['percent_missing'], ascending = False) # sort the values
    
    data_types_df = pd.DataFrame(df.dtypes).reset_index().rename(columns = {"index" : "variable",
                                                                0 : "data_type"}) # rename columns
    
    missing_value_df = missing_value_df.merge(data_types_df, on = "variable") # join the dataframe with datatype
    
    missing_value_df.percent_missing = round(missing_value_df.percent_missing*100, 2) # format the percent_missing
    
    return missing_value_df[missing_value_df.percent_missing > 0]



def connect_to_s3(aws_access_key_id, aws_secret_access_key):
    """Methods that connects to s3"""

    s3_client = boto3.client(
        "s3",
        aws_access_key_id=aws_access_key_id,
        aws_secret_access_key=aws_secret_access_key
    )

    print("Connection to s3 made")

    return s3_client



def load_df_to_s3(df, key, s3_bucket, aws_access_key_id, aws_secret_access_key):
    """Function that writes a data frame as a .csv file to a s3 bucket"""
    
    s3_client = connect_to_s3(aws_access_key_id, aws_secret_access_key)
    
    csv_buffer = StringIO() # create buffer to temporarily store the Data Frame
    df.to_csv(csv_buffer, index=False) # code to write the data frame as csv file
    s3_client.put_object(
            Bucket=s3_bucket, Key=key, Body=csv_buffer.getvalue()
        ) # this code writes the temp stored csv file and writes to s3

    print(f"The transformed data in the following location s3://{s3_bucket}/{key}")

from src.extract import extract_transactional_data
from src.transform import identify_and_remove_duplicates
from src.load_to_s3 import load_df_to_s3

# fetch the environment variables from the .env file using the getenv function
# libraries to load the environment variables
import os
aws_access_key=os.getenv("aws_access_key")
aws_secret_access_key=os.getenv("aws_secret_access_key")
# define the key and s3 bucket
key = "etl/sh_online_trans_final.csv"
aws_s3_bucket = "waia-march-bootcamp"

# extracting the online transaction data from the tables in the database and carrying out some transformation tasks
print("Extracting the data from our database")
ot_transformed = extract_transactional_data()

# remove the duplicates
print("Removing any duplicates")
ot_wout_duplicates = identify_and_remove_duplicates(ot_transformed)

# load the data to s3
print("Loading data to s3")
load_df_to_s3(ot_wout_duplicates, key, aws_s3_bucket, aws_access_key, aws_secret_access_key)
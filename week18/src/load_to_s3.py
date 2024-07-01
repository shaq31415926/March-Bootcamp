import boto3
from io import StringIO


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

    csv_buffer = StringIO()  # create buffer to temporarily store the Data Frame
    df.to_csv(csv_buffer, index=False)  # code to write the data frame as csv file
    response = s3_client.put_object(
        Bucket=s3_bucket, Key=key, Body=csv_buffer.getvalue()
    )  # this code writes the temp stored csv file and writes to s3

    print(f"The transformed data in the following location s3://{s3_bucket}/{key}")
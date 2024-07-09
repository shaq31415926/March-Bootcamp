def identify_and_remove_duplicates(df):
    """Function that identifies and removes duplicated rows of data"""

    if df.duplicated().sum() > 0:
        df_cleaned = df.drop_duplicates(keep='first')

        print("The shape of the data frame after removing duplicates is", df_cleaned.shape)
    else:
        df_cleaned = df
        print("This data frame contains no duplicates")

    return df_cleaned
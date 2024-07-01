import pandas as pd
import sqlite3


def extract_transactional_data():
    # connect to db
    conn = sqlite3.connect("../week16/data/bootcamp_db")

    # query that extracts and transform the data
    query = """
    select ot.*,
	   case when description is null then 'UNKNOWN' else description end as description
    from online_transactions ot 
    left join (select *
               from stock_description
               where description <> '?') sd on ot.stock_code = sd.stock_code
    where customer_id <> ''
        and ot.stock_code not in ('BANK CHARGES', 'POST', 'D', 'M', 'CRUK')
    """

    ot_w_desc = pd.read_sql(query, conn)

    print("The shape of the data is", ot_w_desc.shape)

    return ot_w_desc
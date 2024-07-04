# ETL Pipeline

## Introduction

This code contains the steps to build an ETL pipeline that carries out the following tasks:

- Extracts transactional data from a local database
- Identifies and removes duplicates
- Loads the transformed data to a s3 bucket

## Requirements
The minimum requirements:
- Python 3+

## Instructions on how to execute the code

1. Clone the repository, and change the directory to **March-Bootcamp/week18**:
```
git clone https://github.com/shaq31415926/March-Bootcamp.git
```

If you need a reminder how to clone a repository, check out this link [here](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository).

If you have never worked with git before, you will need to install it and you can find more information [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

If you have already cloned the repository, locate the **March-Bootcamp/week18** folder:

```
git pull
```


2. Install the libraries that you will need to run `main.py`

Mac users:
```
pip3 install -r requirements.txt
```

Window users:
```
pip3 install -r requirements.txt
```


3. Copy the `.env.copy` file to `.env`and fill out the environment variables.


4. Run the `main.py` script

Mac users:
```
python3 main.py
```

Window users:
```
python main.py
```

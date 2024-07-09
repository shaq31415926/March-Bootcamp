# ETL Pipeline

## Introduction

This code contains the steps to build an ETL pipeline that carries out the following tasks:

- Extracts transactional data from a local database
- Identifies and removes duplicates
- Loads the transformed data to a s3 bucket

## Requirements
The minimum requirements:
- Docker for Mac: [Docker >= 20.10.2](https://docs.docker.com/docker-for-mac/install/)
- Docker for Windows: 
  - Installation: [Docker](https://docs.docker.com/desktop/install/windows-install/)
  - Manual installation steps for older WSL version: [Docker WSL 2](https://learn.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package)


## Instructions on how to execute the code

1. Clone the repository, and change the directory to **March-Bootcamp/week19**:
```
git clone https://github.com/shaq31415926/March-Bootcamp.git
```

If you need a reminder how to clone a repository, check out this link [here](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository).

If you have never worked with git before, you will need to install it and you can find more information [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

If you have already cloned the repository, locate the **March-Bootcamp/week19** folder:

```
git pull
```


2. Copy the `.env.copy` file to `.env`and fill out the environment variables.
3. Create a data folder in the week19 folder with a copy of the database.

4. Make sure you have Docker Desktop running. 

Create the image which carries out all the steps:
```
docker image build -t etl .
```

Run the etl pipeline using docker:
```
docker run --env-file .env etl
```

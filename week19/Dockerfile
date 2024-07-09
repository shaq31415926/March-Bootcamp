# deriving the python image
FROM python:3.8-slim

# create a working directory in Docker
WORKDIR /app

# copies all the source code into docker
COPY . /app

# install the libraries we need to execute the code
RUN pip install -r requirements.txt

# tell docker to run the code
CMD ["python", "main.py"]
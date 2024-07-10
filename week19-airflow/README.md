# Running DAGs in Airflow


## Requirements
The minimum requirements:
- Docker for Mac: [Docker >= 20.10.2](https://docs.docker.com/docker-for-mac/install/)
- Docker for Windows: 
  - Installation: [Docker](https://docs.docker.com/desktop/install/windows-install/)
  - Manual installation steps for older WSL version: [Docker WSL 2](https://learn.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package)


## Instructions

1. Create a [DockerFile](https://github.com/shaq31415926/Sep-Bootcamp/blob/main/week20/Dockerfile) which fetches a docker image and copies the dags and python code across. 

Information about the image we are using can be found here: https://github.com/puckel/docker-airflow

2. If you have already launched airflow webserver, you need to kill all containers to use port number 8080 to host airflow:

```docker stop $(docker ps -a -q)```

3. Build a docker image called `local-airflow` on your local machine:

```docker image build -t local-airflow .```

4. Run airflow on port number 8080:

Without passing the .env file:

```docker run -d -p 8080:8080 local-airflow webserver```

If you want to pass the .env file:

```docker run --env-file .env -d -p 8080:8080 local-airflow webserver```

5. Access airflow webserver at http://localhost:8080
# elastic-workshop-setup
Docker setup to spin up a local elasticsearch/kibana instance and pre-populate an index

## Data Set:
 - The data set used in this setup is from https://www.kaggle.com/datasets/yelp-dataset/yelp-dataset/data?select=yelp_academic_dataset_business.json 
    - Download the json file, extract and store in the root level of the cloned repo.

## docker-compose.yml
 - Contains the manifest for container creation and setup

## elasticsearch.Dockerfile
 - Contains build steps for the `elasticsearch` container being set up in `docker-compose.yml'
 - This file orchestrating:
    - Installation of needed requirements.
    - Copying the data set file and supplimental scripts into the elasticsearch container.
    - Kicking off the process to start elastic and populate an index with the data set file.

## load_data.py
 - Helper script to bulk load data into the local elastic container

## start_and_load_elasticsearch.sh
 - Bash file that will:
   - Start elasticsearch container
   - Wait for the container to be up/ready
   - Run `load_data.py`
   - Keep elasticsearch container running

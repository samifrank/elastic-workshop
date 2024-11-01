# start_and_load.Dockerfile
FROM elasticsearch:8.8.0
#Use the root user to install python and copy needed files over
USER root
# Install Python to be able to run load_data.py
RUN apt-get update && apt-get install -y python3 python3-pip
#Copy the data file into the container
COPY yelp_academic_dataset_business.json /usr/share/elasticsearch/yelp_academic_dataset_business.json
# Copy the Python script into the container
COPY load_data.py /usr/share/elasticsearch/load_data.py
# Copy the wait script into the container
COPY start_and_load_elasticsearch.sh /usr/share/elasticsearch/start_and_load_elasticsearch.sh
# Install python dependencies
RUN pip3 install elasticsearch
# Make the wait script executable
RUN chmod +x /usr/share/elasticsearch/start_and_load_elasticsearch.sh
# Switch back to the elasticsearch user
USER elasticsearch
# Start Elasticsearch and then run the wait script. Once elasticsearch is ready, the python script gets kicked off to load data
CMD ["/bin/bash", "-c", "/usr/share/elasticsearch/start_and_load_elasticsearch.sh"]
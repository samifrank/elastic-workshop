#!/bin/sh
# start_and_load_elasticsearch.sh

# Start Elasticsearch in the background
/usr/local/bin/docker-entrypoint.sh eswrapper &

# Wait until Elasticsearch is up
until curl -s http://localhost:9200 >/dev/null; do
  echo "Waiting for Elasticsearch to start..."
  sleep 5
done

# Run the Python script
python3 /usr/share/elasticsearch/load_data.py

# Keep the container running
tail -f /dev/null
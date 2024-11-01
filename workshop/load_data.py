from elasticsearch import Elasticsearch, helpers
import json

CLIENT = Elasticsearch('http://localhost:9200')

WORKING_INDEX = 'yelp-business'

def generate_bulk_upload():
    with open('yelp_academic_dataset_business.json') as f:
        data = f.readlines()
        for line in data:
            doc = json.loads(line)
            yield {
                "_index": WORKING_INDEX,
                "_source": doc
            }

if __name__ == '__main__':
    #Start with fresh unedited index on each startup
    try:
        if CLIENT.indices.exists(index=WORKING_INDEX):
            print(f'{WORKING_INDEX} index already exists. Deleting it and creating a new one.')
            CLIENT.indices.delete(index=WORKING_INDEX)

        CLIENT.indices.create(index=WORKING_INDEX, body={
                                                            "settings": {
                                                                "number_of_shards": 1,
                                                                "number_of_replicas": 0
                                                            }
                                                        
                                                        }
                            )
        print(f'Bulk uploading data to {WORKING_INDEX} index')
        helpers.bulk(CLIENT, generate_bulk_upload())
        print(f'Bulk upload successful')

    except Exception as e:
        print(f'Error: {e}')

    
        
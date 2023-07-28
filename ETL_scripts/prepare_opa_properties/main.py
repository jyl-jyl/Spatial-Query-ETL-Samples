import json
from google.cloud import storage
import functions_framework


@functions_framework.http
def prepare_data(request):
	client = storage.Client()
	raw_bucket = client.bucket('musa509s23_team02_raw_data')
	processed_bucket = client.bucket('musa509s23_team02_prepared_data')

	print('downloading data from raw bucket')
	raw_blob = raw_bucket.blob('opa_properties/opa_properties.json')
	content = raw_blob.download_as_string()
	data = json.loads(content)

	print('converting from json to jsonl ...')
	json_data = ''
	for feature in data['features']:
		row = feature['properties']
		if(feature['geometry'] is None) :
			row['geog'] = None
		else:
			row['geog'] = json.dumps(feature['geometry'])
		json_data += json.dumps(row) + '\n'


	print("uploading to prepared bucket object ...")
	processed_blob = processed_bucket.blob('opa_properties/opa_properties.jsonl')
	processed_blob.upload_from_string(json_data, content_type='application/json')

	return 'OK'




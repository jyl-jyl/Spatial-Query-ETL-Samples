import json
import requests
from google.cloud import storage
import functions_framework

@functions_framework.http
def extract_data(request):
	url = 'https://phl.carto.com/api/v2/sql?filename=opa_properties_public&format=geojson&skipfields=cartodb_id&q=SELECT+*+FROM+opa_properties_public'

	client = storage.Client()
	bucket = client.bucket('musa509s23_team02_raw_data')

	print("fetching data from url ...")
	resp = requests.get(url)
	data = resp.json();

	print("converting json to string ...")
	json_data = json.dumps(data)

	blob = bucket.blob('opa_properties/opa_properties.json')

	print("uploading to bucket object ...")
	blob.upload_from_string(json_data, content_type='application/json')
	return 'OK'


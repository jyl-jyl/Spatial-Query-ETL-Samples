from google.cloud import bigquery
import functions_framework

@functions_framework.http
def load_data(request):
	client = bigquery.Client(project='musa-509-2023-spring')

	query = """
	    CREATE OR REPLACE EXTERNAL TABLE `source_data.census_population_2020` 
	    OPTIONS (
	  		description = 'Census Population 2020 - Processed Data',
	  		uris = ['gs://jingyili_musa509_processed_data/census_population_2020/data.csv'],
	  		format = 'CSV',
	  		max_bad_records = 0
		)
	"""
	query_job = client.query(query)  # Make an API request.

	return 'OK'



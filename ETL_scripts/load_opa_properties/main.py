from google.cloud import bigquery
import functions_framework

@functions_framework.http
def load_data(request):
	from google.cloud import bigquery
	print("Creating client ...")
	client = bigquery.Client(project='musa509s23-team1-philly-cama')

	query = """
	    CREATE OR REPLACE EXTERNAL TABLE `source.opa_properties` (
			`general_construction` STRING,
			`category_code` STRING,
			`topography` STRING,
			`mailing_address_2` STRING,
			`suffix` STRING,
			`taxable_building` STRING,
			`cross_reference` STRING,
			`street_name` STRING,
			`total_area` STRING,
			`census_tract` STRING,
			`number_of_bedrooms` STRING,
			`total_livable_area` STRING,
			`garage_type` STRING,
			`unit` STRING,
			`owner_1` STRING,
			`exterior_condition` STRING,
			`number_of_rooms` STRING,
			`assessment_date` STRING,
			`other_building` STRING,
			`exempt_land` STRING,
			`site_type` STRING,
			`basements` STRING,
			`house_number` STRING,
			`number_of_bathrooms` STRING,
			`mailing_address_1` STRING,
			`street_code` STRING,
			`mailing_street` STRING,
			`building_code_description` STRING,
			`date_exterior_condition` STRING,
			`sale_date` STRING,
			`number_stories` STRING,
			`separate_utilities` STRING,
			`house_extension` STRING,
			`pin` STRING,
			`fuel` STRING,
			`sale_price` STRING,
			`street_designation` STRING,
			`homestead_exemption` STRING,
			`geog` STRING,
			`location` STRING,
			`interior_condition` STRING,
			`building_code` STRING,
			`market_value` STRING,
			`year_built_estimate` STRING,
			`geographic_ward` STRING,
			`fireplaces` STRING,
			`view_type` STRING,
			`type_heater` STRING,
			`zip_code` STRING,
			`zoning` STRING,
			`mailing_zip` STRING,
			`market_value_date` STRING,
			`quality_grade` STRING,
			`garage_spaces` STRING,
			`central_air` STRING,
			`state_code` STRING,
			`book_and_page` STRING,
			`taxable_land` STRING,
			`unfinished` STRING,
			`frontage` STRING,
			`utility` STRING,
			`year_built` STRING,
			`recording_date` STRING,
			`mailing_care_of` STRING,
			`parcel_shape` STRING,
			`mailing_city_state` STRING,
			`beginning_point` STRING,
			`category_code_description` STRING,
			`depth` STRING,
			`exempt_building` STRING,
			`objectid` STRING,
			`parcel_number` STRING,
			`owner_2` STRING,
			`street_direction` STRING,
			`registry_number` STRING,
			`off_street_open` STRING,
			`sewer` STRING
	    )
	    OPTIONS (
	  		description = 'OPA properties data - Prepared Data',
	  		uris = ['gs://musa509s23_team01_prepared_data/opa_properties/opa_properties.jsonl'],
	  		format = 'JSON',
	  		max_bad_records = 0
		)
	"""
	print("executing query ...")
	query_job = client.query(query)  # Make an API request.

	query = """
		CREATE OR REPLACE TABLE `core.opa_properties`
		CLUSTER BY (geog)
		AS (
		  SELECT *, objectid as propery_id 
		  FROM `source.opa_properties`
		)
	"""

	return 'OK'


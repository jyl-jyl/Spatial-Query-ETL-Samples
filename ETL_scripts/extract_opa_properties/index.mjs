import fetch from 'node-fetch';
import storage from '@google-cloud/storage';
import functions from '@google-cloud/functions-framework';


functions.http('extract_data', async (req, res) => {
	const url = 'https://phl.carto.com/api/v2/sql?filename=opa_properties_public&format=geojson&skipfields=cartodb_id&q=SELECT+*+FROM+opa_properties_public';

	const client  = new storage.Storage();
	const bucket = client.bucket('musa509s23_team01_raw_data');

	const resp = await fetch(url);
	const data = await resp.json();

	const jsonData = JSON.stringify(data);
	const blob = bucket.file('opa_properties/opa_properties.json');
	await blob.save(jsonData, { resumable:false });

	console.log('Done!');
	res.status(200).send('OK!');

})






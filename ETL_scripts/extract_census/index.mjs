import fetch from 'node-fetch';
import storage from '@google-cloud/storage';
import functions from '@google-cloud/functions-framework';


functions.http('extract_data', async (req, res) => {
	const url = 'https://api.census.gov/data/2020/dec/pl?get=NAME,GEO_ID,P1_001N&for=block%20group:*&in=state:42%20county:*';

	const client  = new storage.Storage();
	const bucket = client.bucket('jingyili_musa509_raw_data');

	const resp = await fetch(url);
	const data = await resp.json();

	const jsonData = JSON.stringify(data);
	const blob = bucket.file('census/census_population_2020.json');
	await blob.save(jsonData, { resumable:false });

	console.log('Done!');
	res.status(200).send('OK!');

})






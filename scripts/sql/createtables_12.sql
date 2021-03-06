SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;

BEGIN;
	/*----------------------------RAW Rec10 table--------------------------*/
		DROP TABLE IF EXISTS raw_rec10_12 CASCADE;
		CREATE TABLE IF NOT EXISTS raw_rec10_12(
			pcn varchar,
			recordCode varchar,
			propertyUse varchar,
			name varchar,
			address1 varchar,
			address2 varchar,
			address3 varchar,
			zip varchar,
			marketdata1 varchar,
			marketdata2 varchar,
			marketdata3 varchar,
			marketdata4 varchar,
			flags varchar
			);

	/*----------------------------RAW Rec20 table--------------------------*/
		DROP TABLE IF EXISTS raw_rec20_12 CASCADE;
		CREATE TABLE raw_rec20_12(
			pcn varchar,
			recordCode varchar,
			legalLine1 varchar,
			legalLine2 varchar,
			legalLine3 varchar,
			zipPOD varchar,
			zipBarcode varchar
		);	

	/*----------------------------RAW Rec35 table--------------------------*/
		DROP TABLE IF EXISTS raw_rec35_12 CASCADE;
		CREATE TABLE raw_rec35_12(
			pcn varchar,
			recordCode varchar,
			assessment1_type varchar,
			assessment1_authority varchar,
			assessment1_amount varchar,
			assessment2_type varchar,
			assessment2_authority varchar,
			assessment2_amount varchar,
			assessment3_type varchar,
			assessment3_authority varchar,
			assessment3_amount varchar,
			assessment4_type varchar,
			assessment4_authority varchar,
			assessment4_amount varchar,
			assessment5_type varchar,
			assessment5_authority varchar,
			assessment5_amount varchar,
			assessment6_type varchar,
			assessment6_authority varchar,
			assessment6_amount varchar,
			assessment7_type varchar,
			assessment7_authority varchar,
			assessment7_amount varchar,
			assessment8_type varchar,
			assessment8_authority varchar,
			assessment8_amount varchar,
			assessment9_type varchar,
			assessment9_authority varchar,
			assessment9_amount varchar,
			assessment10_type varchar,
			assessment10_authority varchar,
			assessment10_amount varchar,
			assessment11_type varchar,
			assessment11_authority varchar,
			assessment11_amount varchar,
			assessment12_type varchar,
			assessment12_authority varchar,
			assessment12_amount varchar,
			assessment13_type varchar,
			assessment13_authority varchar,
			assessment13_amount varchar,
			assessment14_type varchar,
			assessment14_authority varchar,
			assessment14_amount varchar,
			assessment15_type varchar,
			assessment15_authority varchar,
			assessment15_amount varchar,
			assessment16_type varchar,
			assessment16_authority varchar,
			assessment16_amount varchar,
			assessment17_type varchar,
			assessment17_authority varchar,
			assessment17_amount varchar,
			assessment18_type varchar,
			assessment18_authority varchar,
			assessment18_amount varchar,
			assessment19_type varchar,
			assessment19_authority varchar,
			assessment19_amount varchar,
			assessment20_type varchar,
			assessment20_authority varchar,
			assessment20_amount varchar,
			assessment21_type varchar,
			assessment21_authority varchar,
			assessment21_amount varchar,
			assessment22_type varchar,
			assessment22_authority varchar,
			assessment22_amount varchar,
			assessment23_type varchar,
			assessment23_authority varchar,
			assessment23_amount varchar
			);

	/*----------------------------RAW Rec36 table--------------------------*/
		DROP TABLE IF EXISTS raw_rec36_12 CASCADE;
		CREATE TABLE raw_rec36_12(
			pcn varchar,
			recordCode varchar,
			assessment1_type varchar,
			assessment1_authority varchar,
			assessment1_amount varchar,
			assessment2_type varchar,
			assessment2_authority varchar,
			assessment2_amount varchar,
			assessment3_type varchar,
			assessment3_authority varchar,
			assessment3_amount varchar,
			assessment4_type varchar,
			assessment4_authority varchar,
			assessment4_amount varchar,
			assessment5_type varchar,
			assessment5_authority varchar,
			assessment5_amount varchar,
			assessment6_type varchar,
			assessment6_authority varchar,
			assessment6_amount varchar,
			assessment7_type varchar,
			assessment7_authority varchar,
			assessment7_amount varchar,
			assessment8_type varchar,
			assessment8_authority varchar,
			assessment8_amount varchar,
			assessment9_type varchar,
			assessment9_authority varchar,
			assessment9_amount varchar,
			assessment10_type varchar,
			assessment10_authority varchar,
			assessment10_amount varchar,
			assessment11_type varchar,
			assessment11_authority varchar,
			assessment11_amount varchar,
			assessment12_type varchar,
			assessment12_authority varchar,
			assessment12_amount varchar,
			assessment13_type varchar,
			assessment13_authority varchar,
			assessment13_amount varchar,
			assessment14_type varchar,
			assessment14_authority varchar,
			assessment14_amount varchar,
			assessment15_type varchar,
			assessment15_authority varchar,
			assessment15_amount varchar,
			assessment16_type varchar,
			assessment16_authority varchar,
			assessment16_amount varchar,
			assessment17_type varchar,
			assessment17_authority varchar,
			assessment17_amount varchar,
			assessment18_type varchar,
			assessment18_authority varchar,
			assessment18_amount varchar,
			assessment19_type varchar,
			assessment19_authority varchar,
			assessment19_amount varchar,
			assessment20_type varchar,
			assessment20_authority varchar,
			assessment20_amount varchar,
			assessment21_type varchar,
			assessment21_authority varchar,
			assessment21_amount varchar,
			assessment22_type varchar,
			assessment22_authority varchar,
			assessment22_amount varchar,
			assessment23_type varchar,
			assessment23_authority varchar,
			assessment23_amount varchar
			);

	/*----------------------------RAW Rec40 table--------------------------*/
		DROP TABLE IF EXISTS raw_rec40_12 CASCADE;
		CREATE TABLE raw_rec40_12(
			pcn varchar,
			recordCode varchar,
			taxDistCode varchar,
			propUseCode varchar,
			filler varchar,
			currSOHVal varchar,
			acres varchar,
			SOHBaseYear varchar,
			agriLandVal varchar,
			assessedVal varchar,
			marketVal varchar,
			newConstrVal varchar,
			demolitionVal varchar,
			landVal varchar,
			buildingVal varchar,
			taxableVal varchar,
			exemptionVal varchar,
			prev_agriLandVal varchar,
			prev_assessedVal varchar,
			prev_marketVal varchar,
			prev_newConstrVal varchar,
			prev_demolitionVal varchar,
			prev_landVal varchar,
			prev_buildingVal varchar,
			prev_taxableVal varchar,
			prev_exemptionVal varchar,
			petitionNo varchar,
			exemptionCaseNo varchar
			);
	/*-----------------------------Property table-------------------------*/
	DROP TABLE IF EXISTS property_12 CASCADE;
	CREATE TABLE IF NOT EXISTS property_12(
		pcn varchar PRIMARY KEY,
		propertyUse varchar REFERENCES PropUseLookup(code),
		name varchar,
		address1 varchar,
		address2 varchar,
		address3 varchar,
		zip varchar,
		marketVal numeric
	);
	CREATE INDEX ON property_12(marketVal);

	/*-----------------------------Assessments table-------------------------*/
	DROP TABLE IF EXISTS assessments_12 CASCADE;
	CREATE TABLE IF NOT EXISTS assessments_12(
		pcn varchar REFERENCES property_12(pcn),
		type varchar,
		auth varchar,
		amount numeric
	);
	CREATE INDEX ON assessments_12(pcn);
	CREATE INDEX ON assessments_12(auth);
	
	/*-----------------------------Tax table-------------------------*/
	DROP TABLE IF EXISTS tax_12 CASCADE;
	CREATE TABLE IF NOT EXISTS tax_12(
		pcn varchar REFERENCES property_12(pcn),
		tax numeric
	);
	CREATE INDEX ON tax_12(pcn);
COMMIT;
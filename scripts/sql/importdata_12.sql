SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;

BEGIN;
	INSERT INTO property_12
	SELECT
		a.pcn,
		a.propertyUse,
		name,
		address1,
		address2,
		address3,
		zip,
		NULLIF(marketval, '')::numeric
	FROM raw_rec10_12 a
	LEFT JOIN raw_rec40_12 b
	ON a.pcn = b.pcn;

	INSERT INTO assessments_12
	SELECT
		pcn,
		assessment1_type,
		assessment1_authority,
		CASE
			WHEN  assessment1_amount ='' THEN 0.0
			ELSE NULLIF(assessment1_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment2_type,
		assessment2_authority,
		CASE
			WHEN  assessment2_amount ='' THEN 0.0
			ELSE NULLIF(assessment2_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment3_type,
		assessment3_authority,
		CASE
			WHEN  assessment3_amount ='' THEN 0.0
			ELSE NULLIF(assessment3_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment4_type,
		assessment4_authority,
		CASE
			WHEN  assessment4_amount ='' THEN 0.0
			ELSE NULLIF(assessment4_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment5_type,
		assessment5_authority,
		CASE
			WHEN  assessment5_amount ='' THEN 0.0
			ELSE NULLIF(assessment5_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment6_type,
		assessment6_authority,
		CASE
			WHEN  assessment6_amount ='' THEN 0.0
			ELSE NULLIF(assessment6_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment7_type,
		assessment7_authority,
		CASE
			WHEN  assessment7_amount ='' THEN 0.0
			ELSE NULLIF(assessment7_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment8_type,
		assessment8_authority,
		CASE
			WHEN  assessment8_amount ='' THEN 0.0
			ELSE NULLIF(assessment8_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment9_type,
		assessment9_authority,
		CASE
			WHEN  assessment9_amount ='' THEN 0.0
			ELSE NULLIF(assessment9_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment10_type,
		assessment10_authority,
		CASE
			WHEN  assessment10_amount ='' THEN 0.0
			ELSE NULLIF(assessment10_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment11_type,
		assessment11_authority,
		CASE
			WHEN  assessment11_amount ='' THEN 0.0
			ELSE NULLIF(assessment11_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment12_type,
		assessment12_authority,
		CASE
			WHEN  assessment12_amount ='' THEN 0.0
			ELSE NULLIF(assessment12_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment13_type,
		assessment13_authority,
		CASE
			WHEN  assessment13_amount ='' THEN 0.0
			ELSE NULLIF(assessment13_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment14_type,
		assessment14_authority,
		CASE
			WHEN  assessment14_amount ='' THEN 0.0
			ELSE NULLIF(assessment14_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment15_type,
		assessment15_authority,
		CASE
			WHEN  assessment15_amount ='' THEN 0.0
			ELSE NULLIF(assessment15_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment16_type,
		assessment16_authority,
		CASE
			WHEN  assessment16_amount ='' THEN 0.0
			ELSE NULLIF(assessment16_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment17_type,
		assessment17_authority,
		CASE
			WHEN  assessment17_amount ='' THEN 0.0
			ELSE NULLIF(assessment17_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment18_type,
		assessment18_authority,
		CASE
			WHEN  assessment18_amount ='' THEN 0.0
			ELSE NULLIF(assessment18_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment19_type,
		assessment19_authority,
		CASE
			WHEN  assessment19_amount ='' THEN 0.0
			ELSE NULLIF(assessment19_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment20_type,
		assessment20_authority,
		CASE
			WHEN  assessment20_amount ='' THEN 0.0
			ELSE NULLIF(assessment20_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment21_type,
		assessment21_authority,
		CASE
			WHEN  assessment21_amount ='' THEN 0.0
			ELSE NULLIF(assessment21_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment22_type,
		assessment22_authority,
		CASE
			WHEN  assessment22_amount ='' THEN 0.0
			ELSE NULLIF(assessment22_amount, '0.0')::numeric
		END
	FROM raw_rec35_12
	UNION
	SELECT
		pcn,
		assessment23_type,
		assessment23_authority,
		CASE
			WHEN  assessment23_amount ='' THEN 0.0
			ELSE NULLIF(assessment23_amount, '0.0')::numeric
		END
	FROM raw_rec35_12;
COMMIT;
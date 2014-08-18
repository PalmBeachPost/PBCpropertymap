SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;


DROP TABLE IF EXISTS mergedshapes;

CREATE TABLE mergedshapes (
	parid varchar PRIMARY KEY,
	geom geometry
);

INSERT INTO mergedshapes
SELECT parid, max(geom) FROM parcel
WHERE parid IS NOT NULL
GROUP BY parid

INSERT INTO mergedshape
SELECT subid, max(geom) FROM condos
WHERE subid IS NOT NULL
GROUP BY subid;
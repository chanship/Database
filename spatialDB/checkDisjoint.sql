/*Create table and Insert data*/
CREATE TABLE usc (name varchar, geom geometry);
INSERT INTO usc VALUES
	('1', 'POINT(-118.296533 34.023753)'),
	('2', 'POINT(-118.291199 34.025383)'),
	('3', 'POINT(-118.296326 34.02145)'),
	('4', 'POINT(-118.2922648 34.0228343)'),
	('5', 'POINT(-118.2844681 34.0216204)'),
	('6', 'POINT(-118.286512 34.020889)'),
	('7', 'POINT(-118.287737 34.020364)'),
	('8', 'POINT(-118.287602 34.024392)'),
	('9', 'POINT(-118.288682 34.017077)'),
	('10', 'POINT(-118.2917071 34.018593)')
;
SELECT 	name, ST_AsText(geom) FROM usc;

/*Compute the Convex hull for 10 points and print it*/
SELECT 	ST_AsText(ST_ConvexHull(ST_Collect(geom))) as ConvexHull
FROM 	usc
;

/*Find out if the two polygons overlap*/
SELECT 	ST_Overlaps(
			ST_AsText(ST_MakePolygon(ST_AddPoint(Line1, Point1))),
			ST_AsText(ST_MakePolygon(ST_AddPoint(Line2, Point2))) 
    	)
FROM 	(
    	SELECT	P1.Line AS Line1, P1.FirstPoint AS Point1, P2.Line AS Line2, P2.FirstPoint AS Point2
		 FROM	(SELECT 	ST_AsText(ST_MakeLine(geom)) AS Line, ST_StartPoint(ST_MakeLine(geom)) AS FirstPoint
		 		 FROM 	usc
		 		 WHERE 	name in ('1','2','8','9','10')) AS P1,
        		(SELECT 	ST_AsText(ST_MakeLine(geom)) AS Line, ST_StartPoint(ST_MakeLine(geom)) AS FirstPoint
		 		 FROM 	usc 
		 		 WHERE 	name in ('3','4','5','6','7')) AS P2
		) AS Polygons
;



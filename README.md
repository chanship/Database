# [Spatial Database]Convex Hull, Disjoint, Epitrochoid

Compute the convex hull, disjoint based on PostGIS library.
Draw epitrochoid on the GPS point generation. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Installing

Follow the guide of the link https://cloud.google.com/sql/docs/postgres/quickstart
to create a PostgreSQL instance. 

Download Google Earth on your laptop, install it.
https://www.google.com/earth/download/gep/agree.html

## Running the tests

1. You need to create/generate a set of [latitude,longitude] spatial coordinations for 10 locations.
You can get the coordinates by using Google Maps. Select any point and right click then choose "What's here?"


2. KML is a map-oriented file format, with XML tags. Each location you surveyed will be a 'placemark' in your
.kml file(specified using coords and labels)

```
	<Placemark>
		<name>1.Vermont/Jefferson</name>
		<styleUrl>#z1</styleUrl>
		<Point>
			<coordinates>-118.291464,34.025461,0</coordinates>
		</Point>
	</Placemark>
```

3. Compute the convex hull for 10 points using Postgres with PostGIS functions.
* Convex Hull : the smallest convex polygon that contains the point set
http://mathworld.wolfram.com/ConvexHull.html

4. Create a polygon using points #1,#2,#3,#9,#10(in that order), and another polygon with  the 
remaining points in order(#4,#5,#6,#7,#8). 
Then find out if the two polygons disjoint - yes/no
https://postgis.net/docs/ST_Disjoint.html

5. Based on certain location, generate a set of latitude-longitude coordinates that lie 
along a Epitrochoid curve.
http://www-history.mcs.st-and.ac.uk/Curves/Epitrochoid.html

```
Parametric Equations: (a = 5, b = 3, c = 5)
x = (a + b) cos(t) - c cos((a/b + 1)t),
y = (a + b) sin(t) - c sin((a/b + 1)t)
```

Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg. Using the above equations, loop through t from 0.00 to n*Pi (eg. Using the above equations, loop through t from 0.00 to n*Pi (eg. Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg. Using the above equations, loop through t from 0.00 to n*Pi (eg. Using the above equations, loop through t from 0.00 to n*Pi (eg. Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg. Using the above equations, loop through t from 0.00 to n*Pi (eg. Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg. Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg. Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg. Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg.Using the above equations, loop through t from 0.00 to n*Pi (eg. 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might 2*Pi; note that 'n' might need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), need to be more than 2, for the curve close on itself; and, t is in radians, not degrees), steps of 0.01. That will give you the sequence (x,y) points that make up Epitrochoid steps of 0.01. That will give you the sequence (x,y) points that make up Epitrochoid steps of 0.01. That will give you the sequence (x,y) points that make up Epitrochoid steps of 0.01. That will give you the sequence (x,y) points that make up Epitrochoid steps of 0.01. That will give you the sequence (x,y) points that make up Epitrochoid steps of 0.01. That will give you the sequence (x,y) points that make up Epitrochoid steps of 0.01. That will give you the sequence (x,y) points that make up Epitrochoid steps of 0.01. That will give you the sequence (x,y) points that make up Epitrochoid steps of 0.01. That will give you the sequence (x,y) points that make up Epitrochoid steps of 0.01. That will give you the sequence (x,y) points that make up Epitrochoid steps

## Built With

* [RazorSQL](https://razorsql.com/) - SQL editor used
* [GCP](https://cloud.google.com/sql/docs/postgres/quickstart) - Postgres DB environment
* [PostGIS](https://postgis.net/) - PostGIS library for spatial database engine

## Issues

In order to run ST_Disjoint query(inputs are points, lines -> polygons), there are many related functions for
parsing/processing geometric data from PostGIS. (ST_MakeLine, ST_StartPoint -> ST_AddPoint ->
ST_MakePolygon). In addition, for exporting kml format result, functions such as ST_GeomFromText,
ST_Collect are additionally used. For drawing/making polygons on google map, their consisting points are to
be ordered appropriately for having no self-crossing figure. I think that SQL-based geometrical analyzing
method looks really efficient compare to raw-level processing based on program (other data-structure or
algorithms).


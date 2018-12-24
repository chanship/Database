# Database

CSCI 585 - Database Systems

## 1. Data Modeling(ER Diagram)

#### A. Assumption 
1. A single item(property) can have many posts based on its start_date(+duration)
2. A post can have multiple sublease contracts based on its contract period. (Also, a single post can have many renters based on multiple contracts)
3. The owner and renter cannot be 1:1, which means the owner can be renter at specific time and the renter can be owner when they buy item(property).

#### B. Entity Set
1. Entity Set List : USER, OWNER, RENTER, PAYMENT, BANK_ACCOUNT, CARD, PAYPAL, CONTRACT, COMMENT, TO_RENTER, TO_ITEM, RATE, ITEM, VIDEO, PICTURE, OPTION, POST

#### C. Relationship

Num | Entity | Relationship   | Connectivity | Entity
--- | ------ | ----------------- | ------------ | ------ 
1 | USER | has payment options of | 1:N | PAYMENT 
2 | ITEM | has comments of | 0:N | TO_ITEM
3 | ITEM | is posted for | 0:N | POST
4 | ITEM | has images of | 5:N | PICTURE
5 | ITEM | contains video of | 0:N | VIDEO
6 | ITEM | has property options of | 0:N | OPTION
7 | ITEM | is rated as | 0:N | RATE
8 | OWNER | owns | 1:N | ITEM
9 | OWNER | advertises | 0:N | POST
10 | OWNER | writes | 0:N | COMMENT
11 | TO_RENTER | is towards | 1:1 | RENTER
12 | RENTER | leaves (comment on) | 0:N | COMMENT
13 | RENTER | rates | 0:1 | RATE
14 | RENTER | rented based on | 0:N | CONTRACT
15 | CONTRACT | is paid by | 1:1 | PAYMENT
16 | POST | is made with | 0:N | CONTRACT

![ER-Diagram](https://github.com/chanship/Database/blob/master/data_modeling(ER_Diagram)/er-diagram-shome.png)

## 2. SQL
- based on MySQL

A database for a social networking application consists of the following tables:USERS (USER_ID, FNAME, LNAME, GENDER, DATE_OF_BIRTH)FRIENDSHIPS (INVITER_ID, INVITEE_ID, STATUS)POSTS (POST_ID, USER_ID, TEXT)COMMENTS (COMMENT_ID, POST_ID, USER_ID, TEXT)The primary key for each table is bolded.

1. List the USER_ID, FNAME, LNAME of friends of the user whose id is 5.
![Q1](https://github.com/chanship/Database/blob/master/SQL_dml/Q1_explain.png)

2. List the USER_ID, FNAME, LNAME, GENDER, DAY_OF_BIRTH of all pending friends (usersthat invited this user as friend but have not yet been accepted) of the user whose id is 1.
![Q2](https://github.com/chanship/Database/blob/master/SQL_dml/Q2_explain.png)

3. List the USER_ID, FNAME, LNAME of female mutual friends between users 1 and 2.
![Q3](https://github.com/chanship/Database/blob/master/SQL_dml/Q3_explain.png)

4. List the USER_ID of female users who were born after ‘1990-12-20’ and commented on posts ofUSER_ID=10. Show their friends count in a separate column.
![Q4](https://github.com/chanship/Database/blob/master/SQL_dml/Q4_explain.png)

5. List the user ids of up to 10 pairs of users where their distances are exactly 2 (i.e., they do not havedirect friendship and share at least one common friend).
![Q5](https://github.com/chanship/Database/blob/master/SQL_dml/Q5_explain.png)

6. List the user ids of up to 10 pairs of users where one is male and the other is female, and eachcomments on the other’s posts at least 5 times.
![Q6](https://github.com/chanship/Database/blob/master/SQL_dml/Q6_explain.png)


## 3. Spatial Database

a database that is optimized to store and query data related to objects inspace, including points, lines and polygons

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
![usc_upc_campus_10points](https://github.com/chanship/Database/blob/master/spatialDB/usc_upc_campus_10points.jpg)

3. Compute the convex hull for 10 points using Postgres with PostGIS functions.
* Convex Hull : the smallest convex polygon that contains the point set
http://mathworld.wolfram.com/ConvexHull.html
![convexhull](https://github.com/chanship/Database/blob/master/spatialDB/convexhull.jpg)


4. Create a polygon using points #1,#2,#3,#9,#10(in that order), and another polygon with  the 
remaining points in order(#4,#5,#6,#7,#8). 
Then find out if the two polygons disjoint - yes/no
https://postgis.net/docs/ST_Disjoint.html

![disjoint](https://github.com/chanship/Database/blob/master/spatialDB/disjoint.jpg)

5. compute a set of latitude-longitude coordinates that lie along a Epitrochoid curve.(in KML)
Based on certain location, generate a set of latitude-longitude coordinates that lie 
along a Epitrochoid curve.
http://www-history.mcs.st-and.ac.uk/Curves/Epitrochoid.html

```
Parametric Equations: (a = 5, b = 3, c = 5)
x = (a + b) cos(t) - c cos((a/b + 1)t),
y = (a + b) sin(t) - c sin((a/b + 1)t)
```

![epitrochoid](https://github.com/chanship/Database/blob/master/spatialDB/epitrochoid.jpg)

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





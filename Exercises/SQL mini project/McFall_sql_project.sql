/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */
SELECT name
FROM Facilities
WHERE membercost != 0
;
/*	name
0	Tennis Court 1
1	Tennis Court 2
2	Massage Room 1
3	Massage Room 2
4	Squash Court*/

/* Q2: How many facilities do not charge a fee to members? */
SELECT COUNT( name ) 
FROM Facilities
WHERE membercost = 0
;
/*no_fee
0	4*/

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */
SELECT facid,
        name,
        membercost,
        monthlymaintenance
FROM Facilities
WHERE membercost / monthlymaintenance < 0.2
    AND membercost != 0
;
/*facid	name	membercost	monthlymaintenance
0	0	Tennis Court 1	5.0	200
1	1	Tennis Court 2	5.0	200
2	4	Massage Room 1	9.9	3000
3	5	Massage Room 2	9.9	3000
4	6	Squash Court	3.5	80*/

/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */
SELECT *
FROM Facilities
WHERE facid IN (1,5)
;
/*facid	name	membercost	guestcost	initialoutlay	monthlymaintenance
0	1	Tennis Court 2	5.0	25.0	8000	200
1	5	Massage Room 2	9.9	80.0	4000	3000*/

/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */
SELECT name,
        monthlymaintenance,
        CASE WHEN monthlymaintenance > 100 THEN 'expensive'
        ELSE 'cheap' END AS is_it_cheap
FROM Facilities
;
/*name	monthlymaintenance	is_it_cheap
0	Tennis Court 1	200	expensive
1	Tennis Court 2	200	expensive
2	Badminton Court	50	cheap
3	Table Tennis	10	cheap
4	Massage Room 1	3000	expensive
5	Massage Room 2	3000	expensive
6	Squash Court	80	cheap
7	Snooker Table	15	cheap
8	Pool Table	15	cheap*/

/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */
SELECT  firstname,
        surname
FROM Members
WHERE firstname != 'GUEST'
;
/*firstname	surname
0	Darren	Smith
1	Tracy	Smith
2	Tim	Rownam
3	Janice	Joplette
4	Gerald	Butters
5	Burton	Tracy
6	Nancy	Dare
7	Tim	Boothe
8	Ponder	Stibbons
9	Charles	Owen
10	David	Jones
11	Anne	Baker
12	Jemima	Farrell
13	Jack	Smith
14	Florence	Bader
15	Timothy	Baker
16	David	Pinker
17	Matthew	Genting
18	Anna	Mackenzie
19	Joan	Coplin
20	Ramnaresh	Sarwin
21	Douglas	Jones
22	Henrietta	Rumney
23	David	Farrell
24	Henry	Worthington-Smyth
25	Millicent	Purview
26	Hyacinth	Tupperware
27	John	Hunt
28	Erica	Crumpet
29	Darren	Smith*/

/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */
SELECT DISTINCT f.name AS facility_name,
    CONCAT(m.firstname, ' ', m.surname) AS member_name
FROM Bookings b
LEFT JOIN Facilities f
ON b.facid = f.facid
LEFT JOIN Members m
ON b.memid = m.memid
WHERE f.name LIKE 'Tennis Court%'
AND m.firstname != 'GUEST'
;
/*facility_name	member_name
0	Tennis Court 1	Anne Baker
1	Tennis Court 1	Burton Tracy
2	Tennis Court 1	Charles Owen
3	Tennis Court 1	David Farrell
4	Tennis Court 1	David Jones
5	Tennis Court 1	David Pinker
6	Tennis Court 1	Douglas Jones
7	Tennis Court 1	Erica Crumpet
8	Tennis Court 1	Florence Bader
9	Tennis Court 1	Gerald Butters
10	Tennis Court 1	Jack Smith
11	Tennis Court 1	Janice Joplette
12	Tennis Court 1	Jemima Farrell
13	Tennis Court 1	Joan Coplin
14	Tennis Court 1	John Hunt
15	Tennis Court 1	Matthew Genting
16	Tennis Court 1	Nancy Dare
17	Tennis Court 1	Ponder Stibbons
18	Tennis Court 1	Ramnaresh Sarwin
19	Tennis Court 1	Tim Boothe
20	Tennis Court 1	Tim Rownam
21	Tennis Court 1	Timothy Baker
22	Tennis Court 1	Tracy Smith
23	Tennis Court 2	Anne Baker
24	Tennis Court 2	Burton Tracy
25	Tennis Court 2	Charles Owen
26	Tennis Court 2	Darren Smith
27	Tennis Court 2	David Farrell
28	Tennis Court 2	David Jones
29	Tennis Court 2	Florence Bader
30	Tennis Court 2	Gerald Butters
31	Tennis Court 2	Henrietta Rumney
32	Tennis Court 2	Jack Smith
33	Tennis Court 2	Janice Joplette
34	Tennis Court 2	Jemima Farrell
35	Tennis Court 2	John Hunt
36	Tennis Court 2	Millicent Purview
37	Tennis Court 2	Nancy Dare
38	Tennis Court 2	Ponder Stibbons
39	Tennis Court 2	Ramnaresh Sarwin
40	Tennis Court 2	Tim Boothe
41	Tennis Court 2	Tim Rownam
42	Tennis Court 2	Timothy Baker
43	Tennis Court 2	Tracy Smith*/

/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */
SELECT  f.name AS facility_name,
        CONCAT(m.firstname, ' ', m.surname) AS member_name,
        CASE WHEN b.memid = 0 THEN f.guestcost        --Select the correct cost, guests have id=0
            ELSE f.membercost END AS cost
FROM Bookings b
LEFT JOIN Facilities f
ON b.facid = f.facid
LEFT JOIN Members m
ON b.memid = m.memid
WHERE b.starttime >= '20120914' AND b.starttime < DATEADD(day, 1, '20120914')
AND  CASE WHEN b.memid = 0 THEN f.guestcost        --Cannot filter on a derived column so must restate CASE
            ELSE f.membercost END > 30
ORDER BY cost DESC
;
/*facility_name	member_name	cost
0	Massage Room 1	GUEST GUEST	80.0
1	Massage Room 1	GUEST GUEST	80.0
2	Massage Room 1	GUEST GUEST	80.0
3	Massage Room 2	GUEST GUEST	80.0*/

/* Q9: This time, produce the same result as in Q8, but using a subquery. */
SELECT  sq.name AS facility_name,
        CONCAT(m.firstname, ' ', m.surname) AS member_name,
        sq.cost
FROM (   SELECT  f.name,
                b.memid,
                CASE WHEN b.memid = 0 THEN f.guestcost       --Creates a table of booking from the specified date
                    ELSE f.membercost END AS cost            --with the cost column derived
        FROM Bookings b
        LEFT JOIN Facilities f
        ON b.facid = f.facid
        WHERE b.starttime >= '20120914' AND b.starttime < DATEADD(day, 1, '20120914')) sq
LEFT JOIN Members m
ON sq.memid = m.memid
WHERE sq.cost > 30          --This works now because the cost column was derived in a subquery
ORDER BY sq.cost DESC
;
/*facility_name	member_name	cost
0	Massage Room 1	GUEST GUEST	80.0
1	Massage Room 1	GUEST GUEST	80.0
2	Massage Room 1	GUEST GUEST	80.0
3	Massage Room 2	GUEST GUEST	80.0*/

/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */
SELECT *       --Creates the full revenue table as a subquery and then filters in the outer query
FROM(
    SELECT  f.name,
            SUM(CASE WHEN b.memid = 0 THEN f.guestcost
                ELSE f.membercost END) AS revenue
    FROM Bookings b
    LEFT JOIN Facilities f
    ON b.facid = f.facid
    GROUP BY f.name) sq
WHERE sq.revenue < 1000
ORDER BY sq.revenue DESC
;
/*name	revenue
0	Badminton Court	604.5
1	Pool Table	265.0
2	Snooker Table	115.0
3	Table Tennis	90.0*/

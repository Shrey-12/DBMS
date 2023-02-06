-- Active: 1671709889479@@127.0.0.1@3306@test

CREATE DATABASE test;
USE test;

CREATE TABLE Student(
    snum INT PRIMARY KEY,
    sname VARCHAR(20),
    major VARCHAR(40),
    level VARCHAR(20),
    sage INT
);

DROP TABLE Student;

DROP TABLE Class;

DROP TABLE Enrolled;

DROP TABLE Faculty;



CREATE TABLE Class(
    name VARCHAR(40) PRIMARY KEY,
    meets_at VARCHAR(20),
    room VARCHAR(20),
    fid INT
    --FOREIGN KEY(fid) REFERENCES Faculty(fid) ON DELETE CASCADE
);

CREATE TABLE Enrolled(
    snum INT,
    cname VARCHAR(40),
    FOREIGN KEY(snum) REFERENCES Student(snum) ON DELETE CASCADE,
    FOREIGN KEY(cname) REFERENCES Class(name) ON DELETE CASCADE,
    PRIMARY KEY(snum,cname)

);

CREATE TABLE Faculty(
    fid INT PRIMARY KEY,
    fname VARCHAR(20),
    deptid INT
);


SELECT sname,sage FROM Student;
SELECT * 
FROM Student
WHERE sage>18;

SELECT snum
FROM Enrolled
WHERE cname="Database Systems";

SELECT sname
FROM Student
WHERE snum IN(SELECT snum FROM Enrolled WHERE cname="Database Systems");

SELECT fname
FROM Faculty
WHERE deptid=20;

INSERT INTO Student VALUES
(051135593,"Maria White","English","SR",21),
(060839453,"Charles Harris","Architecture","SR",22),
(099354543,"Susan Martin","Law","JR",20),
(112348546,"Joseph Thompson","Computer Science","SO",19),
(115987938,"Christopher Garcia","Computer Science","JR",20),
(132977562,"Angela Martinez","History","SR",20),
(269734834,"Thomas Robinson","Psychology","SO",18),
(280158572,"Margaret Clark","Animal Science","FR",18),
(301221823,"Juan Rodriguez","Psychology","JR",20),
(318548912,"Dorthy Lewis","Finance","FR",18),
(320874981,"Daniel Lee","Electrical Engineering","FR",17),
(322654189,"Lisa Walker","Computer Science","SO",17),
(348121549,"Paul Hall","Computer Science","JR",18),
(351565322,"Nancy Allen","Accounting","JR",19),
(451519864,"Mark Young","Finance","FR",18),
(455798411,"Luis Hernandez","Electrical Engineering","FR",17),
(462156489,"Donald King","Mechanical Engineering","SO",19),
(550156548,"George Wright","Education","SR",21),
(552455318,"Ana Lopez","Computer Engineering","SR",19),
(556784565,"Kenneth Hill","Civil Engineering","SR",21),
(567354612,"Karen Scott","Computer Engineering","FR",18),
(573284895,"Steven Green","Kinesiology","SO",19),
(574489456,"Betty Adams","Economics","JR",20),
(578875478,"Edward Baker","Veterinary Medicine","SR",21);

INSERT INTO Class VALUES
("Data Structures","MWF 10","R128",489456522),
("Database Systems","MWF 12:30-1:45","1320 DCL",142519864),
("Operating System Design","TuTh 12-1:20","20 AVW",489456522),
("Archaeology of the Incas","MWF 3-4:15","R128",248965255),
("Aviation Accident Investigation","TuTh 1-2:50","Q3",011564812),
("Air Quality Engineering","TuTh 10:30-11:45","R15",011564812),
("Introductory Latin","MWF 3-4:15","R12",248965255),
("American Political Parties","TuTh 2-3:15","20 AVW",619023588),
("Social Cognition","Tu 6:30-8:40","R15",159542516),
("Perception","MTuWTh 3","Q3",489221823),
("Multivariate Analysis","TuTh 2-3:15","R15",090873519),
("Patent Law","F 1-2:50","R128",090873519),
("Urban Economics","MWF 11","20 AVW",489221823),
("Organic Chemistry","TuTh 12:30-1:45","R12",489221823),
("Marketing Research","MW 10-11:15","1320 DCL",489221823),
("Seminar in American Art","M 4","R15",489221823),
("Orbital Mechanics","MWF 8","1320 DCL",011564812),
("Dairy Herd Management","TuTh 12:30-1:45","R128",356187925),
("Communication Networks","MW 9:30-10:45","20 AVW",141582651),
("Optical Electronics","TuTh 12:30-1:45","R15",254099823),
("Intoduction to Math","TuTh 8-9:30","R128",489221823);

INSERT INTO Faculty VALUES
(142519864,'Ivana Teach',20),
(242518965,'James Smith',68),
(141582651,'Mary Johnson',20),
(011564812,'John Williams',68),
(254099823,'Patricia Jones',68),
(356187925,'Robert Brown',12),
(489456522,'Linda Davis',20),
(287321212,'Michael Miller',12),
(248965255,'Barbara Wilson',12),
(159542516,'William Moore',33),
(090873519,'Elizabeth Taylor',11),
(486512566,'David Anderson',20),
(619023588,'Jennifer Thomas',11),
(489221823,'Richard Jackson',33),
(548977562,'Ulysses Teach',20);

INSERT INTO Enrolled VALUES
(112348546,"Database Systems"),
(115987938,"Database Systems"),
(348121549,"Database Systems"),
(322654189,"Database Systems"),
(552455318,"Database Systems"),
(455798411,"Operating System Design"),
(552455318,"Operating System Design"),
(567354612,"Operating System Design"),
(112348546,"Operating System Design"),
(115987938,"Operating System Design"),
(322654189,"Operating System Design"),
(567354612,"Data Structures"),
(552455318,"Communication Networks"),
(455798411,"Optical Electronics"),
(301221823,"Perception"),
(301221823,"Social Cognition"),
(301221823,"American Political Parties"),
(556784565,"Air Quality Engineering"),
(099354543,"Patent Law"),
(574489456,"Urban Economics");


--LAB 2

SELECT *
FROM Class 
WHERE room = "R128";

SELECT *
FROM Faculty
WHERE Faculty.fid IN(
    SELECT Class.fid
    FROM Class
    WHERE room="R128"
);

SELECT *
FROM Faculty
WHERE fid IN(
    SELECT fid
    FROM Class
    WHERE name="Data Structures"
);

SELECT cname
FROM Enrolled
WHERE snum IN (
    SELECT snum
    FROM Student
    WHERE sname="Joseph Thompson"
);

SELECT sname
FROM Student
WHERE snum IN(
    SELECT DISTINCT(snum)
    FROM Enrolled
);


--LAB 3
SELECT * FROM Student;
SELECT * FROM Faculty;

SELECT * FROM Class;

SELECT * FROM Enrolled;

--1
SELECT AVG(sage),level
FROM Student 
GROUP BY level;

--2
SELECT AVG(sage),level
FROM Student
WHERE NOT level="JR"
GROUP BY level;

--3
SELECT f.fname,COUNT(c.fid)
FROM Faculty f JOIN Class c ON f.fid=c.fid
GROUP BY c.fid;

--4
SELECT Student.sname,COUNT(Enrolled.snum)
FROM Student NATURAL JOIN Enrolled 
WHERE Enrolled.cname="Database Systems"
GROUP BY Student.sname
EXCEPT(
SELECT Student.sname,COUNT(Enrolled.snum)
FROM Student NATURAL JOIN Enrolled 
WHERE Enrolled.cname="Operating System Design"
GROUP BY Student.sname);


--5
SELECT AVG(Student.sage),Enrolled.cname
FROM Student
NATURAL JOIN Enrolled
GROUP BY Enrolled.cname
HAVING COUNT(Enrolled.cname)>=2;

--6
SELECT Faculty.fid,COUNT(Class.name)
FROM Faculty
NATURAL JOIN Class
GROUP BY Class.fid
HAVING COUNT(fid)>1;

--7
SELECT Enrolled.snum
FROM Enrolled
GROUP BY snum
HAVING COUNT(snum)>1;

--8
SELECT *
FROM Student
ORDER BY sage ASC;

--9
SELECT Student.sname,Student.snum,major
FROM Student
WHERE Student.major LIKE '%Engineering';

--10
SELECT COUNT(snum),Student.major
FROM Student
GROUP BY major
HAVING major like '%Engineering';

--LAB 4

--1
WITH finance_majors AS (
  SELECT snum, sname, sage
  FROM Student
  WHERE major = 'Finance'
),
enrolled_with_linda_davis AS (
  SELECT Student.snum, sname, sage
  FROM Enrolled
  JOIN Class ON Enrolled.cname = Class.name
  JOIN Faculty ON Class.fid = Faculty.fid
  JOIN Student ON Enrolled.snum = Student.snum
  WHERE Faculty.fname = 'Linda Davis'
), 
combined AS (
    SELECT *
  FROM finance_majors
  UNION
  SELECT *
  FROM enrolled_with_linda_davis
)

SELECT sname, sage
FROM combined
WHERE sage = (SELECT MIN(sage) FROM combined);

--2

WITH rooms AS (
    SELECT DISTINCT(room)
    FROM Class
),
faculty_rooms AS (
    SELECT fname, room
    FROM Class JOIN Faculty ON Class.fid = Faculty.fid
)
SELECT fname
FROM faculty_rooms
GROUP BY fname
HAVING COUNT(DISTINCT(room)) =(SELECT COUNT(DISTINCT(room)) FROM rooms);

--3
--Find the names of faculty members who teach the minimum number of classes.
WITH class_count AS (
    SELECT fid, COUNT(DISTINCT(name)) as class_count
    FROM Class
    GROUP BY fid
)
SELECT fname
FROM Faculty JOIN class_count ON Faculty.fid = class_count.fid
WHERE class_count = (SELECT MIN(class_count) FROM class_count);

--4
--Find the names of faculty members who do not teach any class.
SELECT fname
FROM Faculty
WHERE fid NOT IN (SELECT fid FROM Class);

--5
WITH StudentGroup(sage,level,count) AS 
(SELECT sage, level, COUNT(snum) as count
 FROM Student
GROUP BY sage, level),

max_cnt(sage,cnt) as
(
    select sage, max(count)
    from StudentGroup 
    group by sage
)

SELECT max_cnt.sage, level FROM StudentGroup, max_cnt WHERE 
StudentGroup.sage = max_cnt.sage and count = cnt;


--(6) Find the courses conducted in room R128 for which at least one student has enrolled
SELECT cname
FROM Enrolled JOIN Class ON Enrolled.cname=Class.name
WHERE Class.room="R128";

--(7) Find the times at which classes occur for those courses for which at least one student has enrolled.
SELECT DISTINCT(cname),meets_at
FROM Enrolled JOIN Class ON Enrolled.cname=Class.name;

--8 
SELECT DISTINCT(sname)
FROM Student JOIN Enrolled ON Student.snum = Enrolled.snum
JOIN Class ON Enrolled.cname = Class.name
WHERE level = 'JR' AND room = 'R128';

--10: Find the classes for which no student has enrolled.
SELECT name
FROM Class
WHERE name NOT IN (SELECT cname FROM Enrolled);

--9
--(9) List the students who are older than 18 years and have a level of SR and whose major is not a branch of

SELECT sname
FROM Student
WHERE sage>18 AND level='SR'AND NOT major LIKE '%Engineering';

SELECT 



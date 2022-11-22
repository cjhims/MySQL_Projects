-- Week10 live faculty session
CREATE database IF NOT EXISTS movie_directory;
USE movie_directory;

CREATE TABLE IF NOT EXISTS actor(
ACT_ID INT NOT NULL,
ACT_NAME VARCHAR(20) NULL DEFAULT NULL,
ACT_GENDER CHAR(1) NULL DEFAULT NULL,
PRIMARY KEY (ACT_ID));
CREATE TABLE IF NOT EXISTS director(
DIR_ID INT NOT NULL,
DIR_NAME VARCHAR(20) NULL DEFAULT NULL,
DIR_PHONE INT NULL DEFAULT NULL,
PRIMARY KEY (DIR_ID));
CREATE TABLE IF NOT EXISTS movies(
MOV_ID INT NOT NULL,
MOV_TITLE VARCHAR(25) NULL DEFAULT NULL,
MOV_YEAR INT NULL DEFAULT NULL,
MOV_LANG VARCHAR(12) NULL DEFAULT NULL,
DIR_ID INT NULL DEFAULT NULL,
PRIMARY KEY (MOV_ID),
FOREIGN KEY (DIR_ID)
REFERENCES director (DIR_ID));
CREATE TABLE IF NOT EXISTS movie_cast(
ACT_ID INT NOT NULL,
MOV_ID INT NOT NULL,
A_ROLE VARCHAR(10) NULL DEFAULT NULL,
PRIMARY KEY (ACT_ID, MOV_ID),
FOREIGN KEY (ACT_ID) REFERENCES actor (ACT_ID),
FOREIGN KEY (MOV_ID) REFERENCES movies (MOV_ID));
CREATE TABLE IF NOT EXISTS rating(
MOV_ID INT NOT NULL,
REV_STARS VARCHAR(25) NULL DEFAULT NULL,
PRIMARY KEY (MOV_ID),
FOREIGN KEY (MOV_ID) REFERENCES movie_directory.movies(MOV_ID));

INSERT INTO ACTOR VALUES (1,'Anisha','f');
INSERT INTO ACTOR VALUES (2,'Pavan','m');
INSERT INTO ACTOR VALUES (3,'Pradeep','m');
INSERT INTO ACTOR VALUES (4,'George','m');
INSERT INTO DIRECTOR VALUES (1,'Rohit', 1234567890);
INSERT INTO DIRECTOR VALUES (2,'Akash', 1345678901);
INSERT INTO DIRECTOR VALUES (3,'Christopher', 1456789012);
INSERT INTO DIRECTOR VALUES (4,'Pamela', 1567890123);
INSERT INTO MOVIES VALUES (1,'ABCD', 2020, 'Hindi', 1);
INSERT INTO MOVIES VALUES (2,'BCDA', 2019, 'Telugu', 1);
INSERT INTO MOVIES VALUES (3,'CDAB', 2021, 'English', 2);
INSERT INTO MOVIES VALUES (4,'DABC', 2018, 'Kannada', 3);
INSERT INTO MOVIES VALUES (5,'HHHH', 2021, 'Kannada', 4);
-- use to avoid foreign key constraint errors --
SET FOREIGN_KEY_CHECKS=0;
INSERT INTO MOVIE_CAST VALUES (1, 2, 'Actress');
INSERT INTO MOVIE_CAST VALUES (1, 1, 'Actress');
INSERT INTO MOVIE_CAST VALUES (3, 3, 'Actor');
INSERT INTO MOVIE_CAST VALUES (3, 2, 'Villain');
INSERT INTO MOVIE_CAST VALUES (4, 4, 'actor');
INSERT INTO RATING VALUES (1,4);
INSERT INTO RATING VALUES (2,2);
INSERT INTO RATING VALUES (3, 5);
INSERT INTO RATING VALUES (4, 4);
-- delete from rating where mov_id=5; --
INSERT INTO RATING VALUES (5, 0);

SELECT MOV_TITLE FROM MOVIES WHERE DIR_ID IN (SELECT DIR_ID FROM DIRECTOR WHERE DIR_NAME = 'akash');

-- Find the title of movies and number of stars for each movie that has at least one rating and find
-- the highest number of stars that movie received. Sort the result by movie title.
SELECT MOV_TITLE, max(REV_STARS) FROM MOVIES INNER
JOIN RATING USING (MOV_ID) GROUP BY MOV_TITLE HAVING
max(REV_STARS)>0 ORDER BY MOV_TITLE;

-- Update rating of all movies directed by ‘Pamela’ to 5 --
SET SQL_SAFE_UPDATES = 0;
UPDATE RATING SET REV_STARS =5 WHERE MOV_ID IN (SELECT MOV_ID FROM MOVIES
WHERE DIR_ID IN (SELECT DIR_ID FROM DIRECTOR WHERE DIR_NAME = 'pamela'));

-- stored procedure on movies based on decreasing ratings movie title, year, language, director, rating --
DELIMITER &&
CREATE PROCEDURE pro()
BEGIN
SELECT movies.mov_title,movies.mov_year,movies.mov_lang,director.*,rating.rev_stars from movies,
director,rating where movies.dir_id=director.dir_id and rating.mov_id=movies.mov_id order by rating.rev_stars;
END &&
DELIMITER ;
call pro();

-- case statement 4,5 good to watch, 3 decent , 2,1 not a good movie --
SELECT movies.mov_title,rating.rev_stars,
CASE
WHEN rating.rev_stars >3 THEN 'Movie good to watch'
WHEN rating.rev_stars>2 THEN 'Movie is decent'
ELSE 'Not a good movie'
END AS verdict
FROM movies,rating where rating.mov_id=movies.mov_id;
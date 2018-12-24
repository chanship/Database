#Q1: List the USER_ID, FNAME, LNAME of friends of the user whose id is 5.
SELECT USER_ID, FNAME, LNAME 
FROM USERS 
WHERE USER_ID IN (
	SELECT INVITER_ID FROM FRIENDSHIPS WHERE STATUS = 1 AND INVITEE_ID = 5
	UNION
	SELECT INVITEE_ID FROM FRIENDSHIPS WHERE STATUS = 1 AND INVITER_ID = 5
);


#Q2: List the USER_ID, FNAME, LNAME, GENDER, DAY_OF_BIRTH of all pending friends (users
#       that invited this user as friend but have not yet been accepted) of the user whose id is 1.
SELECT USER_ID, FNAME, LNAME, GENDER, DATE_OF_BIRTH
FROM USERS
WHERE USER_ID IN (
	SELECT INVITER_ID FROM FRIENDSHIPS
		WHERE INVITEE_ID = 1 AND STATUS = 0
	UNION
	SELECT INVITEE_ID FROM FRIENDSHIPS
		WHERE INVITER_ID = 1 AND STATUS = 0
);


#Q3. List the USER_ID, FNAME, LNAME of female mutual friends between users 1 and 2.
SELECT F.UID, USERS.FNAME, USERS.LNAME FROM (
	SELECT F1.UID FROM 
		(SELECT INVITER_ID AS UID FROM FRIENDSHIPS WHERE INVITEE_ID = 1
			UNION 
			SELECT INVITEE_ID AS UID FROM FRIENDSHIPS WHERE INVITER_ID=1) AS F1
		INNER JOIN
		(SELECT INVITER_ID AS UID FROM FRIENDSHIPS WHERE INVITEE_ID = 2
			UNION 
			SELECT INVITEE_ID AS UID FROM FRIENDSHIPS WHERE INVITER_ID=2) AS F2
		ON F1.UID = F2.UID
) AS F INNER JOIN USERS ON F.UID = USERS.USER_ID
WHERE USERS.GENDER = 'F';

#Q4. List the USER_ID of female users who were born after ‘1990-12-20’ and commented on posts of
#		 USER_ID=10. Show their friends count in a separate column.
SELECT U.USER_ID, COUNT(F.FRIENDS)
FROM 
(SELECT USER_ID
   FROM USERS
   WHERE GENDER = 'F' AND DATE_OF_BIRTH > '1990-12-20' AND USER_ID IN (
      SELECT USER_ID  FROM COMMENTS 
	  WHERE POST_ID IN (SELECT POST_ID FROM POSTS WHERE USER_ID = 10)
	)
) AS U 
INNER JOIN 
(SELECT DISTINCT(F1.USER_ID), F1.FRIENDS FROM 
   (SELECT INVITER_ID AS USER_ID, INVITEE_ID AS FRIENDS FROM FRIENDSHIPS WHERE STATUS = 1
   UNION
   SELECT INVITEE_ID AS USER_ID, INVITER_ID AS FRIENDS FROM FRIENDSHIPS WHERE STATUS = 1
	) AS F1
) AS F
ON U.USER_ID = F.USER_ID
GROUP BY U.USER_ID;


#Q5. List the user ids of up to 10 pairs of users where their distances are exactly 2 (i.e., they do not have
#		 direct friendship and share at least one common friend).
SELECT DISTINCT(RESULT1.REC_FRIEND_A), RESULT1.REC_FRIEND_B
FROM
	(SELECT DIRECT_FRIEND_LIST_RIGHT.A1 AS REC_FRIEND_A, DIRECT_FRIEND_LIST_LEFT.A2 AS REC_FRIEND_B
		FROM 
        (SELECT INVITER_ID AS A1, INVITEE_ID AS A2
			FROM FRIENDSHIPS
			WHERE STATUS = 1
		UNION
		SELECT INVITEE_ID AS A1, INVITER_ID AS A2
			FROM FRIENDSHIPS
			WHERE STATUS = 1
			ORDER BY A1) AS DIRECT_FRIEND_LIST_RIGHT
	INNER JOIN 
    (SELECT INVITER_ID AS A1, INVITEE_ID AS A2
		FROM FRIENDSHIPS
		WHERE STATUS = 1
	UNION
	SELECT INVITEE_ID AS A1, INVITER_ID AS A2
		FROM FRIENDSHIPS
		WHERE STATUS = 1
		ORDER BY A1) AS DIRECT_FRIEND_LIST_LEFT 
	ON DIRECT_FRIEND_LIST_RIGHT.A2 = DIRECT_FRIEND_LIST_LEFT.A1
WHERE DIRECT_FRIEND_LIST_RIGHT.A1 <> DIRECT_FRIEND_LIST_LEFT.A2 
AND (DIRECT_FRIEND_LIST_RIGHT.A1,DIRECT_FRIEND_LIST_LEFT.A2) NOT IN 
	(SELECT INVITER_ID, INVITEE_ID
		FROM FRIENDSHIPS
		WHERE STATUS = 1
	UNION
	SELECT INVITEE_ID, INVITER_ID
		FROM FRIENDSHIPS
		WHERE STATUS = 1)) AS RESULT1 
	LEFT JOIN 
    (SELECT DIRECT_FRIEND_LIST_RIGHT.A1 AS REC_FRIEND_A, DIRECT_FRIEND_LIST_LEFT.A2 AS REC_FRIEND_B 
		FROM 
        (SELECT INVITER_ID AS A1, INVITEE_ID AS A2
			FROM FRIENDSHIPS
			WHERE STATUS = 1
		UNION
		SELECT INVITEE_ID AS A1, INVITER_ID AS A2
			FROM FRIENDSHIPS
			WHERE STATUS = 1
			ORDER BY A1) AS DIRECT_FRIEND_LIST_RIGHT
	INNER JOIN 
    (SELECT INVITER_ID AS A1, INVITEE_ID AS A2
		FROM FRIENDSHIPS
		WHERE STATUS = 1
	UNION
	SELECT INVITEE_ID AS A1, INVITER_ID AS A2
		FROM FRIENDSHIPS
		WHERE STATUS = 1
		ORDER BY A1) AS DIRECT_FRIEND_LIST_LEFT 
    ON DIRECT_FRIEND_LIST_RIGHT.A2 = DIRECT_FRIEND_LIST_LEFT.A1
WHERE DIRECT_FRIEND_LIST_RIGHT.A1 <> DIRECT_FRIEND_LIST_LEFT.A2 
AND (DIRECT_FRIEND_LIST_RIGHT.A1,DIRECT_FRIEND_LIST_LEFT.A2) NOT IN 
	(SELECT INVITER_ID, INVITEE_ID
		FROM FRIENDSHIPS
		WHERE STATUS = 1
	UNION
	SELECT INVITEE_ID, INVITER_ID
	FROM FRIENDSHIPS
	WHERE STATUS = 1)) AS RESULT2 
ON RESULT1.REC_FRIEND_A = RESULT2.REC_FRIEND_B AND RESULT1.REC_FRIEND_B = RESULT2.REC_FRIEND_A
WHERE RESULT1.REC_FRIEND_A < RESULT2.REC_FRIEND_A OR RESULT2.REC_FRIEND_A IS NULL
ORDER BY RESULT1.REC_FRIEND_A
LIMIT 10;

#Q6. List the user ids of up to 10 pairs of users where one is male and the other is female, and each
#		 comments on the other’s posts at least 5 times. 
SELECT DISTINCT(RESULT1.BEST_FRIEND_1), RESULT1.BEST_FRIEND_2
FROM (
	SELECT BF_PAIR.COMMENTER AS BEST_FRIEND_1, BF_PAIR.POSTER AS BEST_FRIEND_2
	FROM USERS AS U1, USERS AS U2,
	(
		SELECT BF1.COMMENTER, BF1.POSTER
		FROM
		(SELECT COM.USER_ID AS COMMENTER,  P.USER_ID AS POSTER
				FROM COMMENTS AS COM, POSTS AS P
				WHERE COM.POST_ID = P.POST_ID
				GROUP BY COM.POST_ID, COM.USER_ID
				HAVING COUNT(COM.COMMENT_ID) >= 5) AS BF1
		  INNER JOIN
          (SELECT P.USER_ID AS COMMENTER,  COM.USER_ID AS POSTER
				FROM COMMENTS AS COM, POSTS AS P
				WHERE COM.POST_ID = P.POST_ID
				GROUP BY COM.POST_ID, COM.USER_ID
				HAVING COUNT(COM.COMMENT_ID) >= 5) AS BF2
		  ON BF1.COMMENTER = BF2.COMMENTER AND BF1.POSTER = BF2.POSTER
	) AS BF_PAIR
	WHERE BF_PAIR.COMMENTER = U1.USER_ID AND BF_PAIR.POSTER = U2.USER_ID
	AND U1.GENDER <> U2.GENDER) AS RESULT1 
LEFT JOIN 
    (
	SELECT BF_PAIR.COMMENTER AS BEST_FRIEND_1, BF_PAIR.POSTER AS BEST_FRIEND_2
	FROM USERS AS U1, USERS AS U2,
	(
		SELECT BF1.COMMENTER, BF1.POSTER
		FROM
		(SELECT COM.USER_ID AS COMMENTER,  P.USER_ID AS POSTER
				FROM COMMENTS AS COM, POSTS AS P
				WHERE COM.POST_ID = P.POST_ID
				GROUP BY COM.POST_ID, COM.USER_ID
				HAVING COUNT(COM.COMMENT_ID) >= 5) AS BF1
		  INNER JOIN
          (SELECT P.USER_ID AS COMMENTER,  COM.USER_ID AS POSTER
				FROM COMMENTS AS COM, POSTS AS P
				WHERE COM.POST_ID = P.POST_ID
				GROUP BY COM.POST_ID, COM.USER_ID
				HAVING COUNT(COM.COMMENT_ID) >= 5) AS BF2
		  ON BF1.COMMENTER = BF2.COMMENTER AND BF1.POSTER = BF2.POSTER
	) AS BF_PAIR
	WHERE BF_PAIR.COMMENTER = U1.USER_ID AND BF_PAIR.POSTER = U2.USER_ID
	AND U1.GENDER <> U2.GENDER) AS RESULT2
ON RESULT1.BEST_FRIEND_1 = RESULT2.BEST_FRIEND_2 AND RESULT1.BEST_FRIEND_2 = RESULT2.BEST_FRIEND_1
WHERE RESULT1.BEST_FRIEND_1 < RESULT2.BEST_FRIEND_1 OR RESULT2.BEST_FRIEND_1 IS NULL
LIMIT 10;
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
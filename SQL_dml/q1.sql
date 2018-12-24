#Q1: List the USER_ID, FNAME, LNAME of friends of the user whose id is 5.
SELECT USER_ID, FNAME, LNAME 
FROM USERS 
WHERE USER_ID IN (
	SELECT INVITER_ID FROM FRIENDSHIPS WHERE STATUS = 1 AND INVITEE_ID = 5
	UNION
	SELECT INVITEE_ID FROM FRIENDSHIPS WHERE STATUS = 1 AND INVITER_ID = 5
);
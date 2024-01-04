/*
! IG Clone Exercises
*/

USE ig_clone;

/* 
! 1. Finding the 5 oldest users
*/

SELECT username, created_at
FROM users
ORDER BY created_at
LIMIT 5;

/* 
! 2. Finding the day of the week the users registers most
*/

SELECT COUNT(created_at),
DAYNAME(created_at)
FROM users
GROUP BY DAYNAME(created_at)
ORDER BY COUNT(created_at) DESC;

/* 
! 3. Finding the users that never posted a photo
*/

SELECT COUNT(user_id), user_id
FROM photos
GROUP BY user_id;

SELECT username, user_id
FROM users
LEFT JOIN photos ON photos.user_id = users.id
WHERE user_id IS NULL;

/* 
! 4. Who has more likes in a single photo
*/

SELECT photo_id, COUNT(photo_id)
FROM likes
GROUP BY photo_id
ORDER BY COUNT(photo_id) DESC;

SELECT username, photos.id
FROM users
JOIN photos ON photos.user_id = users.id
WHERE photos.id = 145;

/* 
! 5. How many times the average user posts
*/

SELECT username, user_id, COUNT(user_id) 
FROM photos
JOIN users ON photos.user_id = users.id
GROUP BY username
ORDER BY COUNT(user_id) DESC;

SELECT image_url from photos where user_id = 23;

SELECT DISTINCT user_id, COUNT(user_id)
FROM photos
GROUP BY user_id;

SELECT (SELECT Count(*) 
FROM   photos) / (SELECT Count(*) 
FROM   users) AS avg; 

/* 
! 6. What are the  hashtags more used
*/

SELECT DISTINCT tag_id, tag_name, COUNT(tag_id)
FROM photo_tags
JOIN tags ON photo_tags.tag_id = tags.id
GROUP BY tag_id
ORDER BY COUNT(tag_id) DESC
LIMIT 7;

/* 
! 7. Identify bots (find users that liked every photo)
*/

SELECT username, user_id, COUNT(photo_id) 
FROM likes
JOIN users ON users.id = likes.user_id
GROUP BY user_id
HAVING COUNT(photo_id) = 257;

/* 
! To dinamically get the numbers of photos even when they 
! were updated
*/
SELECT username, user_id, COUNT(photo_id) 
FROM likes
JOIN users ON users.id = likes.user_id
GROUP BY user_id
HAVING COUNT(photo_id) = (SELECT COUNT(*) FROM photos);

/*
! Testes 
*/

SELECT username 
FROM users
WHERE username IS NULL;

-- Database information
USE ig_clone;



-- Challenge 1
-- Finding  5 oldest users

SELECT * 
FROM users
ORDER BY created_at
LIMIT 5;






-- Challenge 2
-- Day of the week where most users register on?

SELECT
	DAYNAME(created_at) as day,
	COUNT(*) as total
FROM users
GROUP BY day
ORDER BY total DESC;





-- Challenge 3 
-- Inactive Users - Never Uploaded a Photo

SELECT username, IFNULL(image_url, 0) as photo_count FROM users
LEFT JOIN photos
	ON users.id = photos.user_id
WHERE photos.image_url IS NULL;

-- NUMBER of inactive users in database
SELECT 
	IFNULL(COUNT(image_url), 0) as inactive_users_count
FROM users
LEFT JOIN photos
	ON users.id = photos.user_id;






-- Challenge 4
-- Most liked photo contest

SELECT 
	username, 
	photos.id,
	photos.image_url,
	COUNT(*) as total
FROM likes
INNER JOIN photos
	ON likes.photo_id = photos.id
INNER JOIN users
	ON likes.user_id = users.id
GROUP BY likes.photo_id
ORDER BY total DESC
LIMIT 5; -- Top 5 users






-- Challenge 5
-- Calculate avg number of photos per user
-- total number of photos / total number of user

SELECT 
	COUNT(photos.image_url)/COUNT(DISTINCT users.id) AS Avg_Photos_Per_User 
FROM users 
LEFT JOIN photos 
	ON users.id = photos.user_id;





-- Challenge 6
-- Popular hashtags

SELECT tags.tag_name, COUNT(tag_id) as total
FROM photo_tags
RIGHT JOIN tags
	ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC
LIMIT 5;






-- Challenge 7
-- Potential bot users (users who have liked every single photo on site)


SELECT 
	users.username,
	COUNT(*) AS num_likes
FROM users
INNER JOIN likes
	ON likes.user_id = users.id
GROUP BY likes.user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);









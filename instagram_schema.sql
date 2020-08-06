
DROP DATABASE ig_clone;
CREATE DATABASE ig_clone;
USE ig_clone;


-- USER INFORMATION

CREATE TABLE users(
	id INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(255) UNIQUE NOT NULL,
	created_by TIMESTAMP DEFAULT NOW()
	
);



-- PHOTO INFORMATION

CREATE TABLE photos(
	id INT AUTO_INCREMENT PRIMARY KEY, 
	image_url VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	
	-- could add location, caption but not necessary for relation
	
	FOREIGN KEY(user_id) REFERENCES users(id)
	
);


-- COMMENTS

CREATE TABLE comments(
	id INT AUTO_INCREMENT PRIMARY KEY,
	comment_text VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY(photo_id) REFERENCES photos(id),
	FOREIGN KEY(user_id) REFERENCES users(id)
	
);



-- LIKES
-- does not need a primary key id because never will reference

CREATE TABLE likes(
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(photo_id) REFERENCES photos(id),

	PRIMARY KEY(user_id, photo_id) -- guarantees no like combination of user_id and photo_id
);
 

-- FOLLOWERS/FOLLOWEES 
-- table shows a cross reference to following relationship

CREATE TABLE follows(
	follower_id INT NOT NULL,
	followee_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	
	
	FOREIGN KEY(follower_id) REFERENCES users(id),
	FOREIGN KEY(followee_id) REFERENCES users(id),
	
	PRIMARY KEY(follower_id, followee_id)
);



-- HASHTAGS

CREATE TABLE tags (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  tag_name VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);


CREATE TABLE photo_tags (
    photo_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);


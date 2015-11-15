/*
	# Wk 3 homework
    # Student: Mauricio Sanchez
    # Date: Nov 15th 2015
*/

CREATE DATABASE hotel;

# 1. Create tables

CREATE TABLE users(
  user_id INT(6) NOT NULL,
  user_name VARCHAR(255),
  PRIMARY KEY (user_id)
);

CREATE TABLE groups(
  group_id INT(6) NOT NULL,
  group_name VARCHAR(255),
  PRIMARY KEY (group_id)
);

CREATE TABLE rooms(
  room_id INT(6) NOT NULL,
  room_name VARCHAR(255),
  PRIMARY KEY (room_id)
);

CREATE TABLE users_by_group(
  user_id INT(6) NOT NULL,
  group_id INT(6) NOT NULL,
  PRIMARY KEY (user_id, group_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (group_id) REFERENCES groups(group_id) ON DELETE CASCADE
);

CREATE TABLE groups_by_room(
  group_id INT(6) NOT NULL,
  room_id INT(6) NOT NULL,
  PRIMARY KEY (group_id, room_id),
  FOREIGN KEY (group_id) REFERENCES groups(group_id) ON DELETE CASCADE,
  FOREIGN KEY (room_id) REFERENCES rooms(room_id) ON DELETE CASCADE
);

INSERT INTO users 
	(user_id, user_name) 
VALUES
	(1, 'Modesto'),
	(2, 'Ayine'),
    (3, 'Christopher'),
    (4, 'Cheong woo'),
    (5, 'Saulat'),
    (6, 'Heidy');

INSERT INTO groups 
	(group_id,group_name) 
VALUES
	(1, 'I.T'),
	(2, 'Sales'),
    (3, 'Administration'),
    (4, 'Operations');

INSERT INTO rooms
	(room_id,room_name) 
VALUES
	(1, '101'),
	(2, '102'),
    (3, 'Auditorium A'),
    (4, 'Auditorium B');
    
INSERT INTO users_by_group 
	(user_id, group_id) 
VALUES
	(1, 1),
	(2, 1),
    (3, 2),
    (4, 2),
    (5, 3);

INSERT INTO groups_by_room 
	(group_id, room_id) 
VALUES
	(1, 1),
	(1, 2),
    (2, 2),
    (2, 3);

-- All groups, and the users in each group. A group should appear even if there are no users assigned to the group.
SELECT groups.group_name,
	   users.user_name
FROM groups
LEFT JOIN users_by_group 
ON groups.group_id=users_by_group.group_id
LEFT JOIN users
ON users.user_id=users_by_group.user_id
GROUP BY groups.group_name,
	   users.user_name
ORDER BY groups.group_name,
	     users.user_name ASC;
         
-- All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been assigned to them.
SELECT rooms.room_name,
	   groups.group_name
FROM rooms
LEFT JOIN groups_by_room
ON rooms.room_id = groups_by_room.room_id
LEFT JOIN groups
ON groups.group_id = groups_by_room.group_id
GROUP BY rooms.room_name,
	   groups.group_name
ORDER BY rooms.room_name ASC;

-- A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted alphabetically by user, then by group, then by room.
SELECT users.user_name,
	   groups.group_name,
       rooms.room_name AS 'assigned room'
FROM users
LEFT JOIN users_by_group
ON users.user_id = users_by_group.user_id
LEFT JOIN groups
ON groups.group_id = users_by_group.group_id
LEFT JOIN groups_by_room
ON groups_by_room.group_id = groups.group_id
LEFT JOIN rooms
ON rooms.room_id = groups_by_room.room_id
GROUP BY users.user_name,
	   groups.group_name,
       rooms.room_name
ORDER BY users.user_name,
	   groups.group_name,
       rooms.room_name ASC;
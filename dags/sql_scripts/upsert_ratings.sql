BEGIN;

-- Upsert ratings table
UPDATE movies.ratings 
SET movie_rating = ms.rating 
FROM movies.stage_ratings ms 
WHERE movies.ratings.user_id = ms.user_id AND movies.ratings.movie_id = ms.movie_id; 


INSERT INTO movies.ratings 
SELECT ms.* FROM movies.stage_ratings ms LEFT JOIN movies.ratings 
ON ms.user_id = movies.ratings.user_id AND ms.movie_id = movies.ratings.movie_id
WHERE movies.ratings.user_id IS NULL;

DROP TABLE IF EXISTS movies.stage_ratings;

END;
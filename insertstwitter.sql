INSERT INTO users(user_id,user_name, user_screen_name, user_location, user_utc_offset, user_time_zone, user_followers_count, user_friends_count,user_lang, user_description, user_status_count, user_created_at)
SELECT user_id,user_name, user_screen_name, user_location, user_utc_offset, user_time_zone, user_followers_count, user_friends_count,user_lang, user_description, user_status_count, user_created_at
FROM bad_giant_table
ON CONFLICT (user_id)
do nothing;

INSERT INTO tweets(created_at, text, tweet_id, retweet_count, tweet_source, user_id)
SELECT created_at, text, tweet_id, retweet_count, tweet_source, user_id
FROM bad_giant_table;

INSERT INTO replies(tweet_id, in_reply_to_screen_name, in_reply_to_status_id, in_reply_to_user_id)
SELECT tweet_id, in_reply_to_screen_name, in_reply_to_status_id, in_reply_to_user_id
FROM bad_giant_table
where in_reply_to_user_id IS NOT NULL;

INSERT INTO retweet_of_tweet(tweet_id,retweet_of_tweet_id)
SELECT tweet_id,retweet_of_tweet_id
FROM bad_giant_table
where retweet_of_tweet_id IS NOT NULL;


INSERT INTO hashtags(tweet_id,hashtag)
SELECT tweet_id,hashtag1
FROM bad_giant_table
where hashtag1 IS NOT NULL;
UPDATE hashtags
SET hashtag_id= 1
where hashtag_id IS NULL;


INSERT INTO hashtags(tweet_id,hashtag)
SELECT tweet_id,hashtag2
FROM bad_giant_table
where hashtag2 IS NOT NULL;
UPDATE hashtags
SET hashtag_id = 2
where
hashtag_id IS NULL;

INSERT INTO hashtags(tweet_id,hashtag)
SELECT tweet_id,hashtag3
FROM bad_giant_table
where 
hashtag3 IS NOT NULL;
UPDATE hashtags
SET hashtag_id = 3 
where
hashtag_id IS NULL;

INSERT INTO hashtags(tweet_id,hashtag)
SELECT tweet_id,hashtag4
FROM bad_giant_table
where 
hashtag4 IS NOT NULL;
UPDATE hashtags
SET hashtag_id = 4 
where
hashtag_id IS NULL;

INSERT INTO hashtags(tweet_id,hashtag)
SELECT tweet_id,hashtag5
FROM bad_giant_table
where 
hashtag5 IS NOT NULL;
UPDATE hashtags
SET hashtag_id = 5 
where
hashtag_id IS NULL;

INSERT INTO hashtags(tweet_id,hashtag)
SELECT tweet_id,hashtag6
FROM bad_giant_table
where 
hashtag6 IS NOT NULL;
UPDATE hashtags
SET hashtag_id = 6 
where
hashtag_id IS NULL;

Alter table hashtags add primary key (tweet_id,hashtag_id);

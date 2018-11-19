CREATE TABLE users (
user_id bigint PRIMARY KEY,
    user_name character varying(255),
    user_screen_name  character varying(255) unique,
    user_location character varying(255) ,
    user_utc_offset integer,
    user_time_zone character varying(127),
    user_followers_count integer,
    user_friends_count integer,
    user_lang character varying(10),
    user_description varchar(255),
    user_status_count varchar(255),
    user_created_at timestamp with time zone
);

CREATE TABLE  tweets (
created_at timestamp with time zone,
text varchar(255),
tweet_id bigint PRIMARY KEY,
retweet_count int,
tweet_source  varchar(255),
user_id bigint,
foreign key (user_id) references Users(user_id));

CREATE TABLE  replies (
tweet_id bigint PRIMARY KEY,
in_reply_to_screen_name  varchar(255),
in_reply_to_status_id    bigint,
in_reply_to_user_id      bigint NOT NULL,
foreign key (tweet_id) references tweets(tweet_id));


CREATE TABLE  retweet_of_tweet (
tweet_id bigint PRIMARY KEY,
retweet_of_tweet_id bigint NOT NULL,
foreign key (tweet_id) references tweets(tweet_id));

CREATE TABLE hashtags (
tweet_id bigint,
hashtag_id varchar(10),
hashtag varchar(144) NOT NULL,
foreign key (tweet_id) references tweets(tweet_id));
-- DROP TABLE hashtags, retweet_of_tweet, replies, tweets,users;

--1a)
select count(distinct tweet_id) from tweets;
--1b)
Select user_lang,count(user_lang)
from
(select * from tweets natural join users) as newtable
group by
user_lang;

--1c) 
create view tweetlangfrac as
select user_lang, cnt, cnt::float/(sum(cnt) over ()) as fraction_of_tweets from (select user_lang, count(*) as cnt from (select * from tweets natural join Users) as newtable group by user_lang) a order by user_lang;
create view userlangfrac as
select user_lang, usercount, usercount::float/(sum(usercount) over ()) as fraction_of_users from (select user_lang, count(*) as usercount from Users group by user_lang) a order by user_lang;
select user_lang,fraction_of_tweets,fraction_of_users from tweetlangfrac natural join userlangfrac;
--2a)
select
(select cast(count(retweet_of_tweet_id) as float) from retweet_of_tweet)/(select count(distinct tweet_id) from tweets) as fractionretweets;

--2b)
select avg(retweet_count) from tweets;

--2c) 
select
(select cast(count(retweet_count) as float) from tweets where retweet_count=0)/(select count(distinct tweet_id) from tweets) as fractionneverretweeted;

--2d)
select
(select cast(count(*) as float) from
(select tweet_id, retweet_count from tweets where retweet_count< (select avg(retweet_count) from tweets)) as aretweet)/(select count(distinct tweet_id) from tweets) as fractionlessavgretweeted;

--3a)
select count (distinct hashtag) from hashtags;

--3b)

select hashtag,
count(hashtag) as hashtagcount
from 
hashtags
group by hashtags.hashtag
order by hashtagcount
DESC
limit 10;

--3c)
create view hashusers as
select hashtags.tweet_id,hashtags.hashtag,tweets.user_id from hashtags,tweets where hashtags.tweet_id=tweets.tweet_id;
create view hashlang as
select hashusers.user_id,hashusers.hashtag,users.user_lang from hashusers, users where hashusers.user_id=users.user_id;
create view hashtaglangcount as 
select user_lang,hashtag,count(hashtag) as pophashtaglang from hashlang
group by hashlang.user_lang,hashlang.hashtag;
select * from
 (select user_lang, hashtag, pophashtaglang, row_number() over (partition by user_lang order by pophashtaglang desc ) as rownum from hashtaglangcount) tmp          
 where rownum < 4; 

--4a)
select 
(select count(tweet_id) from tweets)-
(select 
(select count(*) from
(select tweets.tweet_id, in_reply_to_status_id from tweets,replies where tweets.tweet_id=replies.in_reply_to_status_id) as repliedto)+
(select count(*) from replies) as rplynorrply) as tweetnoreply;

--4b) 
create view a as
select tweet_id,in_reply_to_status_id, in_reply_to_user_id,user_lang as user2lang from replies,users where users.user_id=replies.in_reply_to_user_id;
create view b as
select user_id,a.tweet_id,in_reply_to_status_id, in_reply_to_user_id,user2lang from tweets,a where a.tweet_id=tweets.tweet_id;
create view c as
select b.user_id,b.tweet_id,in_reply_to_status_id, in_reply_to_user_id,user2lang,user_lang as user1lang from b,users where b.user_id=users.user_id;
select 
(select cast(count(*) as float) from c where user1lang=user2lang)/(select count(*) from c) as probuserreplysamelang;

--4c) 
create view probuser1 as 
select user_lang, userlangcount, userlangcount::float/(sum(userlangcount) over ()) as probuser1 from (select user_lang, count(*) as userlangcount from users as newtable group by user_lang) a order by user_lang;
create view totuser2 as
select
(select cast (count(*) as float) from users)-1
as user2perm;
create view fracuser2 as
select user_lang, count(*)-1 as user2langcount from users as newtable group by user_lang order by user_lang;
create view probuser2 as
select user_lang, user2langcount, user2langcount::float/totuser2.user2perm  as probuser2 from fracuser2,totuser2 order by user_lang;
select sum(probuser) from (select probuser1.user_lang,probuser1,probuser2, probuser1*probuser2 as probuser from probuser1,probuser2 where probuser1.user_lang=probuser2.user_lang) as probuser1user2samelang 








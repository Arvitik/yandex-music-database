SELECT al.album_id, al.album_name, ar.artist_id, ar.artist_name
FROM album al JOIN album_artist aa USING (album_id) JOIN artist ar ON ar.artist_id = aa.artist_id
ORDER BY al.album_id, ar.artist_id;

SELECT ar.artist_id, ar.artist_name, count(aa.album_id) AS album_count
FROM artist ar LEFT JOIN album_artist aa USING (artist_id)
GROUP BY ar.artist_id ORDER BY album_count DESC, ar.artist_id;

SELECT p.playlist_id, p.playlist_name, ps.position, s.song_id, s.song_name
FROM playlist p LEFT JOIN playlist_song ps USING (playlist_id)
LEFT JOIN song s USING (song_id) ORDER BY p.playlist_id, ps.position;

SELECT g.genre_id, g.genre_name, count(sg.song_id) AS song_count
FROM genre g LEFT JOIN song_genre sg USING (genre_id)
GROUP BY g.genre_id ORDER BY song_count DESC, g.genre_id;

SELECT u.user_id, u.user_name, g.genre_name
FROM users u JOIN preference pr USING (preference_id) JOIN genre g USING (genre_id)
ORDER BY u.user_id;

SELECT r.user_id, s.song_id, s.song_name, s.rating, r.reason, g.genre_name
FROM recommendation r JOIN song s USING (song_id)
JOIN preference pr ON pr.preference_id = r.preference_id JOIN genre g ON g.genre_id = pr.genre_id
WHERE r.user_id = 1 ORDER BY s.rating DESC NULLS LAST, s.play_count DESC, s.song_id;

SELECT u.user_id, u.user_name, s.subscriptions_type, s.price, su.start_date, su.end_date,
su.start_date <= current_date AND su.end_date > current_date AS is_active
FROM users u JOIN subscriptions_users su USING (user_id)
JOIN subscriptions s ON s.subscriptions_id = su.subscriptions_id
ORDER BY u.user_id, su.start_date, su.subscriptions_users_id;

SELECT playlist_id, playlist_name, song_count, total_duration
FROM playlist_details ORDER BY song_count DESC, playlist_id;

SELECT DISTINCT e.event_id, e.event_name, e.date, e.geolocation, g.genre_id, g.genre_name
FROM events e JOIN artist_event ae USING (event_id) JOIN artist ar ON ar.artist_id = ae.artist_id
JOIN genre g ON g.genre_id = ar.genre_id ORDER BY e.date, e.event_id, g.genre_id;

SELECT s.subscriptions_id, s.subscriptions_type, count(DISTINCT su.user_id) AS user_count
FROM subscriptions s LEFT JOIN subscriptions_users su ON su.subscriptions_id = s.subscriptions_id
AND su.start_date <= current_date AND su.end_date > current_date
GROUP BY s.subscriptions_id ORDER BY s.subscriptions_id;

SELECT DISTINCT s.song_id, s.song_name, s.duration
FROM playlist_user pu JOIN playlist_song ps USING (playlist_id) JOIN song s USING (song_id)
WHERE pu.user_id = 1 ORDER BY s.song_id;

SELECT e.event_id, e.event_name, e.date, ar.artist_id, ar.artist_name
FROM events e JOIN artist_event ae USING (event_id) JOIN artist ar ON ar.artist_id = ae.artist_id
ORDER BY e.date, e.event_id, ar.artist_id;

SELECT al.album_id, al.album_name, round(avg(s.rating), 2) AS average_rating
FROM album al LEFT JOIN song s USING (album_id)
GROUP BY al.album_id ORDER BY average_rating DESC NULLS LAST, al.album_id;

SELECT ar.artist_id, ar.artist_name, min(s.rating) AS minimum_rating, max(s.rating) AS maximum_rating
FROM artist ar LEFT JOIN song_artist sa USING (artist_id) LEFT JOIN song s USING (song_id)
GROUP BY ar.artist_id ORDER BY ar.artist_id;

SELECT user_id, user_name, age FROM users WHERE age > 18 ORDER BY age, user_id;

SELECT DISTINCT user_id, user_name FROM active_subscriptions
WHERE subscriptions_type = 'Cheap' ORDER BY user_id;

SELECT su.song_user_id, su.listened_at, s.song_id, s.song_name, ar.artist_name
FROM song_user su JOIN song s USING (song_id) JOIN artist ar ON ar.artist_id = s.artist_id
WHERE su.user_id = 1 ORDER BY su.listened_at DESC, su.song_user_id DESC;

SELECT song_id, song_name, play_count, rating FROM song
ORDER BY play_count DESC, rating DESC NULLS LAST, song_id LIMIT 20;

SELECT relname AS table_name, n_live_tup AS estimated_rows,
pg_size_pretty(pg_table_size(relid)) AS table_size,
pg_size_pretty(pg_indexes_size(relid)) AS indexes_size,
pg_size_pretty(pg_total_relation_size(relid)) AS total_size,
pg_size_pretty(pg_database_size(current_database())) AS database_size
FROM pg_stat_user_tables ORDER BY pg_total_relation_size(relid) DESC, relname;

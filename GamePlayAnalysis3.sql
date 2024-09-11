SELECT
player_id, event_date, sum(games_played) over(PARTITION BY player_id ORDER BY event_date)
AS 'games_played_so_far'
FROM activity


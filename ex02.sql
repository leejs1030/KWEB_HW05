SELECT users.id, users.name, seat_number
FROM tickets inner join trains inner join users
on trains.id = tickets.train and tickets.user = users.id and trains.id = 11
ORDER BY seat_number asc;

SELECT users.id, users.name, count(*) as trains_count, sum(distance)/10 as total_distance
FROM tickets inner join trains inner join users
on trains.id = tickets.train and tickets.user = users.id
GROUP BY users.id, users.name
ORDER BY total_distance desc 
LIMIT 0, 6;

SELECT trains.id, types.name as type, s1.name as src_stn, s2.name as dst_stn, Timediff(arrival, departure) as travel_time
FROM trains inner join stations as s1 inner join stations as s2 inner join types
on s1.id = trains.source and s2.id = trains.destination and types.id = trains.type
ORDER BY travel_time desc
LIMIT 0, 6;

SELECT types.name as type, s1.name as src_stn, s2.name as dst_stn, departure, arrival, round(fare_rate / 1000 * distance, -2) as fare
FROM trains inner join stations as s1 inner join stations as s2 inner join types
on s1.id = trains.source and s2.id = trains.destination and types.id = trains.type
ORDER BY departure asc;

SELECT trains.id, types.name as `type`, s1.name as src_stn, s2.name as dst_stn, count(*) as occupied, types.max_seats as maximum
FROM trains inner join tickets inner join stations as s1 inner join stations as s2 inner join types
on s1.id = trains.source and s2.id = trains.destination and types.id = trains.type and tickets.train = trains.id
GROUP BY trains.id, types.name, src_stn, dst_stn, maximum;

SELECT trains.id, types.name as `type`, s1.name as src_stn, s2.name as dst_stn, count(tickets.id) as occupied, types.max_seats as maximum
FROM (trains inner join stations as s1 inner join stations as s2 inner join types
on s1.id = trains.source and s2.id = trains.destination and types.id = trains.type) left outer join tickets
on tickets.train = trains.id
GROUP BY trains.id, types.name, src_stn, dst_stn, maximum;
#GET /fare: Query로 사용자의 ID인 uid를 받아 해당 사용자가 지불해야 하는 총 요금을 응답하는 라우트
SELECT sum(round(fare_rate / 1000 * distance, -2)) as fare
FROM trains inner join types inner join users inner join tickets
on types.id = trains.type and users.id = tickets.user and tickets.train = trains.id
GROUP BY users.id
HAVING users.id = 1; #운임



#GET /train/status: Query로 열차의 ID인 tid를 받아 해당 열차가 매진되었는지 판단하여 응답하는 라우트
#(Hint: 예매된 좌석 수와 최대 좌석 수를 조회하여 비교한다
SELECT trains.id, types.name as `type`, s1.name as src_stn, s2.name as dst_stn, count(tickets.id) as occupied, types.max_seats as maximum
FROM (trains inner join stations as s1 inner join stations as s2 inner join types
on s1.id = trains.source and s2.id = trains.destination and types.id = trains.type) left outer join tickets
on tickets.train = trains.id
GROUP BY trains.id, types.name, src_stn, dst_stn, maximum; #tid별로 예매 좌석 수와 최대 좌석 수를 출력.

SELECT trains.id, types.name as `type`, s1.name as src_stn, s2.name as dst_stn, count(tickets.id) as occupied, types.max_seats as maximum
FROM (trains inner join stations as s1 inner join stations as s2 inner join types
on s1.id = trains.source and s2.id = trains.destination and types.id = trains.type) left outer join tickets
on tickets.train = trains.id
GROUP BY trains.id, types.name, src_stn, dst_stn, maximum
HAVING occupied < maximum and trains.id = ?;
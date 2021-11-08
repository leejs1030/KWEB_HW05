const {runQuery} = require('./database.js');
const express = require('express');
const { parse } = require('dotenv');
const port = 3000;
const app = express();

const getFares = async(uid) => {
    const sql = 'SELECT users.name as name, sum(round(fare_rate / 1000 * distance, -2)) as fare '
    +'FROM trains inner join types inner join users inner join tickets '
    +'on types.id = trains.type and users.id = tickets.user and tickets.train = trains.id '
    +'GROUP BY users.id '
    +'HAVING users.id = ?';
    const result = await runQuery(sql, uid);
    return result;
}

const isFull = async(tid) =>{
    const sql = 'SELECT trains.id, types.name as `type`, s1.name as src_stn, s2.name as dst_stn, count(tickets.id) as occupied, types.max_seats as maximum '
    +'FROM (trains inner join stations as s1 inner join stations as s2 inner join types '
    +'on s1.id = trains.source and s2.id = trains.destination and types.id = trains.type) left outer join tickets '
    +'on tickets.train = trains.id '
    +'GROUP BY trains.id, types.name, src_stn, dst_stn, maximum '
    +'HAVING trains.id = ?';
    const result = await runQuery(sql, [tid]);
    return result;
}

app.get('/fare', async (req, res) => {
    try{
    const {uid} = req.query;
    const {name, fare} = (await getFares(uid))[0];
    // const {name, fare} = (await getFares(parseInt(uid)))[0];
    res.send(`Total fare of ${name} is ${fare} KRW`)
    } catch(e){
        console.error("500 Internal Server Error");
    }
});

app.get('/train/status', async (req, res) => {
    try{
    const {tid} = req.query;
    const {occupied, maximum} = (await isFull(tid))[0];
    // const {occupied, maximum} = (await isFull(parseInt(tid)))[0];
    if(maximum > occupied) res.send(`Train ${tid} is not sold out`);
    else res.send(`Train ${tid} is sold out`);
    } catch(e){
        console.error("500 Internal Server Error");
    }
});

app.listen(port, () => console.log(`Server listening on port ${port}!`));

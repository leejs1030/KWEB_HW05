const {name, fare} = (await getFares(uid))[0];
    // res.send(`Total fare of ${name} is ${fare} KRW`)
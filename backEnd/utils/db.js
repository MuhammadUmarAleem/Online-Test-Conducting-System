const mongoose = require('mongoose');

mongoose.set('strictQuery', true);

mongoose.connect('mongodb+srv://bilalbisharat:kgRQcPkCtC9kUF2M@cluster0.2ixrksw.mongodb.net/', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
});

const db = mongoose.connection;

db.on('error', (err) => {
    console.log('failed to connect to db');
})

db.once('open', () => {
    console.log('connected to database');
});


const express = require('express');
const app = express();
const port = 3000;
const userRouter = require('./route/userRoute');
const bodyParser = require('body-parser');
const morgan = require('morgan');

require('./utils/db');
const cors = require('cors');
app.use(bodyParser.json());
app.use(cors());
app.use(morgan('dev'));


app.use('/api', userRouter);

app.get('/', (req, res) => {
    res.send('Login API');
});

app.listen(port, () => {
    console.log(`Server listening at http://localhost:${port}`);
});

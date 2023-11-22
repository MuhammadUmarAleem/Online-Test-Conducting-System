const express = require('express');
const app = express();
const port = 3000;
const cors = require('cors');

const bodyParser = require('body-parser');

app.use(bodyParser.json());

const userRouter = require('./routes/userRoute');

require('./utils/db');

app.use(cors());

app.user('/api', userRouter);

app.get('/', (req, res) => {
    res.send('Login API');
});

app.listen(port, () => {
    console.log(`Server listening at http://localhost:${port}`);
});

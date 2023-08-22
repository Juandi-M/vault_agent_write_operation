const express = require('express');
const routes = require('./routes/index');

const app = express();

app.use((req, res, next) => {
    console.log(`Request received at ${new Date().toISOString()} for ${req.url}`);
    next();
});

app.use('/', routes);

app.listen(3001, "0.0.0.0", () => {
    console.log("Server is running on port 3001");
});
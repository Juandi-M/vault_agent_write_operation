const express = require('express');
const routes = require('./routes/index');
const { getConfig } = require('./utils/configLoader');

const app = express();

app.use((req, res, next) => {
    console.log(`Request received at ${new Date().toISOString()} for ${req.url}`);
    next();
});

// Example route that uses the configuration dynamically
app.get('/some-config-route', (req, res) => {
    const config = getConfig();
    res.send(config.someValue);  // Send a specific configuration value as a response
});

app.get('/health', (req, res) => {
    const config = getConfig();
    if (config.usingDefault) {
        res.status(500).send("Using default configuration");
    } else {
        res.send("OK");
    }
});

app.use('/', routes);

setTimeout(() => {  // Corrected the typo here
    app.listen(3001, "0.0.0.0", () => {
        console.log("Server is running on port 3001");
    });
}, 2000);  // Delay of 10 seconds

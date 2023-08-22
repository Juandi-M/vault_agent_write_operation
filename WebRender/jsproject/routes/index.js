const express = require('express');
const router = express.Router();
const { getConfig } = require('../utils/configLoader');
const { getRenderedHTML } = require('../utils/htmlRenderer');

router.get("/test", (req, res) => {
    res.send("This is a test!");
});

router.get("/", async (req, res) => {
    // Use getConfig() to get the current configuration
    const config = getConfig();
    
    const renderedHTML = await getRenderedHTML(config);
    res.send(renderedHTML);
});

module.exports = router;
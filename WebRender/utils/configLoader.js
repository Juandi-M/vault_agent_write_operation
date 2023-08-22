const fs = require('fs').promises;
const chokidar = require('chokidar');

let appConfig = {
    value1: "default_value1",
    // ... other defaults
};

let usingDefaultConfig = false;

async function loadConfig() {
    try {
        const data = await fs.readFile("appconfigs.json", "utf8");
        appConfig = JSON.parse(data);
        usingDefaultConfig = false;
    } catch (err) {
        usingDefaultConfig = true;
    }
}

// Initialize by loading config and setting up watcher
loadConfig();
chokidar.watch('appconfigs.json').on('change', loadConfig);

function getConfig() {
    return {
        config: appConfig,
        usingDefault: usingDefaultConfig
    };
}

module.exports = {
    getConfig
};
const fs = require('fs').promises;
const chokidar = require('chokidar');

const CONFIG_PATH = '/app/configs/appconfigs.json';

let appConfig = {
    value1: "the_vaules_from_vault_do_not_work",
    // ... other defaults
};

let usingDefaultConfig = false;

async function loadConfig() {
    try {
        const data = await fs.readFile(CONFIG_PATH, "utf8");
        appConfig = JSON.parse(data);
        usingDefaultConfig = false;
        console.log("Configuration loaded successfully.");
    } catch (err) {
        console.error("Error loading appconfigs.json:", err);
        usingDefaultConfig = true;
    }
}

// Initialize by loading config and setting up watcher
loadConfig();
chokidar.watch(CONFIG_PATH).on('change', loadConfig);

function getConfig() {
    return {
        config: appConfig,
        usingDefault: usingDefaultConfig
    };
}

module.exports = {
    getConfig
};

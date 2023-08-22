const fs = require('fs').promises;
const path = require('path');

async function getRenderedHTML(configInfo) {
    try {
        // Read the template file
        const template = await fs.readFile(path.join(__dirname, '../webTemplates/template.html'), 'utf8');

        // Generate config list HTML
        const configListHtml = Object.entries(configInfo.config)
            .map(([key, value]) => `<li>${key}: <span id="${key}">${value}</span></li>`)
            .join('');

        // Replace placeholders with actual content
        let renderedHTML = template.replace('{{configList}}', configListHtml)
            .replace('{{warningMessage}}', configInfo.usingDefault ? 
            '<div style="background-color: yellow; padding: 10px; text-align: center;">Warning: Using default configuration due to an error loading appconfigs.json.</div>' : '');

        // Continue replacing other placeholders as needed...

        return renderedHTML;

    } catch (err) {
        console.error('Error while rendering the HTML:', err);
        return '';  // Return empty string or a fallback HTML
    }
}

module.exports = {
    getRenderedHTML
};

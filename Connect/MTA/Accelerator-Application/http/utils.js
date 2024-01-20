const fss = require('fs').promises;
const fs = require('fs');
const path = require('path');

async function inject(search, replace) {
    const modsPath = 'mods';
    const modsDirectories = await fss.readdir(modsPath, { withFileTypes: true });

    const mainModFolders = modsDirectories
        .filter((dirent) => dirent.isDirectory())
        .map((dirent) => dirent.name);

    for (const modFolder of mainModFolders) {
        const filePath = path.join(modsPath,modFolder, 'mtaserver.conf');

        try {
            const content = await fss.readFile(filePath, 'utf-8');
            const updatedContent = content.replace(new RegExp(search, 'g'), replace);
            await fss.writeFile(filePath, updatedContent, 'utf-8');
            console.log(`Substituição realizada em ${filePath}`);
        } catch (err) {
            console.error(`Erro ao processar ${filePath}:`, err);
        }
    }
}

module.exports = inject;

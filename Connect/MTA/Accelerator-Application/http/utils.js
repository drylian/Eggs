const fss = require('fs').promises;
const fs = require('fs');
const path = require('path');
const { Readable } = require('stream');
const { finished } = require('stream/promises');
async function inject(search, replace) {
    const modsPath = 'mods';
    const modsDirectories = await fss.readdir(modsPath, { withFileTypes: true });

    const mainModFolders = modsDirectories
        .filter((dirent) => dirent.isDirectory())
        .map((dirent) => dirent.name);

    for (const modFolder of mainModFolders) {
        const filePath = path.join(modsPath, modFolder, 'mtaserver.conf');

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

const download = (async (url, fileName) => {
    const res = await fetch(url);
    const fileStream = fs.createWriteStream(`./${fileName}`, { flags: 'wx' });
    await finished(Readable.fromWeb(res.body).pipe(fileStream));
});
module.exports = { inject, download };

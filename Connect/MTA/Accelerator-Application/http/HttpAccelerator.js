const express = require('express');
const fss = require('fs').promises;
const fs = require('fs');
const zlib = require('zlib');
const path = require("path");
const morgan = require('morgan');

module.exports = class HttpServer {
  constructor(NOClient) {
    this.app = express();
    this.client = NOClient
    this.app.disable('x-powered-by');
    if (process.env.LOGS_LEVEL >= 3) {
      this.app.use(morgan('dev'));
    }
    this.app.use((req, res, next) => {
      if (process.env.LOGS_LEVEL >= 2) console.log("Request : " + req.originalUrl)
      if (req.originalUrl === "/") return res.status(403).send('Forbidden');

      next();
    });
  }

  async start(port) {
    this.app.get('*', async (req, res) => {
      try {
        const modsPath = 'mods';
        const modsDirectories = await fss.readdir(modsPath, { withFileTypes: true });

        const mainModFolders = modsDirectories
          .filter((dirent) => dirent.isDirectory())
          .map((dirent) => dirent.name);

        for (const modFolder of mainModFolders) {
          const clientFiles = path.join(modsPath, modFolder, 'resource-cache', 'http-client-files', req.originalUrl);
          const noClient = path.join(modsPath, modFolder, 'resource-cache', 'http-client-files-no-client-cache', req.originalUrl);

          if (fs.existsSync(clientFiles)) {
            await this.sendFile(res, clientFiles);
            return;
          } else if (this.client && fs.existsSync(noClient)) {
            await this.sendFile(res, noClient);
            return;
          }
        }

        res.status(404).json({ error: 'Not Found' });

      } catch (error) {
        if (process.env.LOGS_LEVEL >= 1) console.error('HTTP SERVER:', error);
        res.status(500).send('Internal Server Error');
      }
    });

    this.app.listen(port, () => {
      if (process.env.LOGS_LEVEL >= 2) console.log('Acelerador está rodando em ' + `http://${process.env.EXPRESS_HOST}:${process.env.EXPRESS_PORT}`);
    });
  }

  async sendFile(res, filePath) {
    const fileContent = await fss.readFile(filePath, 'utf-8');
    zlib.gzip(fileContent, (err, compressedContent) => {
      if (err) {
        if (process.env.LOGS_LEVEL >= 1) console.error('Erro na compressão:', err);
        res.status(500).send('Erro interno do servidor');
      } else {
        const filename = path.basename(filePath);
        res.setHeader('Content-Encoding', 'gzip');
        res.setHeader('Content-Disposition', `attachment; ${filename}`);
        res.send(compressedContent);
      }
    });
  }
}
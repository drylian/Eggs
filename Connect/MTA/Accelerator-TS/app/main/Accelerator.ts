/**
 * Accelerator Base Application
 */
import fastify from 'fastify';
import fastifyCompress from '@fastify/compress';
import fs from "fs";
import { Html } from '../pages';
import path from "path";
import { core, mta } from '../utils/logger';
import { MtaManager } from './Mta';
import { terminal } from './Terminal';
const server = fastify();

server.register(fastifyCompress);

server.get('/', async (_, reply) => {
    if (!process.env.NO_HTML) {
        reply.send(Html());
    } else {
        reply.status(403).send({ error: "Access prohibited" });
    }
});

server.get("*", async (req, reply) => {
    try {
        const modsPath = 'mods';
        const modsDirectories = await fs.promises.readdir(modsPath, { withFileTypes: true });
        const mainModFolders = modsDirectories
            .filter((dirent) => dirent.isDirectory())
            .map((dirent) => dirent.name);
        for (const modFolder of mainModFolders) {
            for (const pather of process.env.RESOURCES_PATHS) {
                const File = path.join(modsPath, modFolder, 'resource-cache', pather, req.originalUrl);

                if (fs.existsSync(File)) {
                    return File;
                }
            }
        }
        reply.status(404).send({ error: "Internal Server Error" });
    } catch (err) {
        const error = err as InstanceType<typeof Error>;
        core.error('HTTP SERVER:', error);
        reply.status(500).send({ error: "Internal Server Error" });
    }
})

server.listen({
    port: process.env.PORT,
    host: "0.0.0.0"
}, async (err, address) => {
    const game = new MtaManager(`./mta-server64 --httpdownloadurl ${process.env.IP}:${process.env.PORT} ${process.env.ARGUMENTS}`);
    if (err) {
        console.error(err);
        process.exit(1);
    }
    core.log(`Accelerator listening on ${address}`);
    mta.log("Starting Multi Theft auto server")
    game.start();
    mta.log("Starting Terminal user")
    terminal.start(game);
});
import { finished } from "stream/promises";
import fs from "fs";
import { Readable } from "stream";
import { ReadableStream } from "stream/web";

/**
 * Downloader
 */
export const download = (async (url:string, fileName:string) => {
    const res = await fetch(url);
    const fileStream = fs.createWriteStream(`./${fileName}`, { flags: 'wx' });
    if(res.body) await finished(Readable.fromWeb(res.body as unknown as ReadableStream).pipe(fileStream));
});
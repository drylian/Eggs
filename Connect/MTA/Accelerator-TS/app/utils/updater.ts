import { download } from "./downloader";
import pkg from "../../package.json";
import { core } from "./logger";

/**
 * Check latest Updates and download updates
 */
export async function Updater() {
    try {
        const response = await fetch('https://raw.githubusercontent.com/drylian/Eggs/main/Connect/MTA/Accelerator-TS/package.json');
        const server = await response.json() as typeof pkg;

        if (pkg.version === server.version) {
            core.log(`The accelerator is updated. [v${pkg.version}].lime-b`);
        } else {
            core.log(`Accelerator is out of date ([v${pkg.version}].red-b < [v${server.version}].lime-b), downloading new update [v${server.version} ].lime-b`);
            if(process.env.AUTO_UPDATE) {
                try {
                    await download("https://github.com/drylian/Eggs/raw/main/Connect/MTA/Accelerator-TS/build/accelerator", "accelerator-update")
                    core.log('restarting to start the new update.');
                    process.exit(0);
                } catch (err) {
                    const error = err as InstanceType<typeof Error>;
                    core.warn('Error updating file:', error.message);
                }
            } else {
                core.log(`auto update disabled, continuing [initiation].green-b.`);
            }
        }
    } catch (e) {
        // ignores
    }
}
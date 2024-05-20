import { config } from "dotenv";
config();
import "./utils/envs";
import { Updater } from "./utils/updater";
import { core } from "./utils/logger";

/**
 * Checks updates of Application
 */
Updater().then(async () => {
    core.info(`Starting Accelerator on port [${process.env.PORT}].green-b.`);
    /**
     * Application IP
     */
    process.env.IP = (await (await fetch('https://ifconfig.me/ip')).text()).trim();
    await import("./main/Accelerator");
});

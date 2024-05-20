/**
 * Application Logger level
 */
if (!process.env.LOGGER || !["Error", "Warn", "Info", "Debug"].includes(process.env.LOGGER)) {
    process.env.LOGGER = "Info";
}
process.env.ARGUMENTS = process.argv.join(" ")

import ChildProcess from "child_process";
import { Argvs } from "./args";
import { core } from "./logger";
const args = Argvs(process.argv);
if (!args.accelerator) {
    core.log("Accelerator without defined port, starting [Multi Theft auto].green-b only");
    process.exit(0);
} else {
    process.env.PORT = Number(args.accelerator);
}

/**
 * Stores other arguments to be placed in the mta at execution
 */
process.env.ARGUMENTS = process.argv.join(" ").replace(`--accelerator ${args.accelerator}`,"");

/**
 * Resources dirsnames in "resource-cache"
 */
if (!process.env.RESOURCES_PATHS) {
    process.env.RESOURCES_PATHS = ["http-client-files", "http-client-files-no-client-cache"];
} else {
    if (Array.isArray(JSON.parse(process.env.RESOURCES_PATHS as unknown as string))) {
        process.env.RESOURCES_PATHS = [...JSON.parse(process.env.RESOURCES_PATHS as unknown as string), "http-client-files"];
    } else {
        core.warn("Process env [RESOURCES_PATHS].yellow-b is not an array, so it will not be used, using standard resources.");
        process.env.RESOURCES_PATHS = ["http-client-files", "http-client-files-no-client-cache"];
    }
}

/**
 * Application Update Status
 */
if (!process.env.AUTO_UPDATE || !["true", "false"].includes(process.env.AUTO_UPDATE as unknown as string)) {
    process.env.AUTO_UPDATE = true;
} else {
    process.env.AUTO_UPDATE = Boolean(process.env.AUTO_UPDATE);
}

/**
 * Application Html view
 */
if (!process.env.NO_HTML || !["true", "false"].includes(process.env.NO_HTML as unknown as string)) {
    process.env.NO_HTML = false;
} else {
    process.env.NO_HTML = Boolean(process.env.NO_HTML);
}
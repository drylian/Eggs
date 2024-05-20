import { core } from "../../utils/logger";
import { MtaManager } from "../Mta";
import { Terminal } from "../Terminal";

/**
 * Accelerator cmds
 * @param term 
 */
export default function Acc(term: Terminal,game:InstanceType<typeof MtaManager> | undefined): void {
    term.cmd({
        name: "mta:restart",
        desc: "Restart MTA via accelerator"
    }, async () => {
        core.log("restarting mta...");
        if(game) game.restart();
    })
    term.cmd({
        name: "mta:stop",
        desc: "Stop MTA via accelerator"
    }, async () => {
        core.log("stopping mta...");
        if(game) game.restart();
    })
    term.cmd({
        name: "mta:start",
        desc: "Start MTA via accelerator"
    }, async () => {
        core.log("starting mta...");
        if(game) game.restart();
    })
}
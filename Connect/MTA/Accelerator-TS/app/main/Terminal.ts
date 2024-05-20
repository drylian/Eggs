/**
 * Application Terminal interactions
 */
import * as readline from 'readline';
import { MtaManager } from './Mta';
import { core } from '../utils/logger';
import { Formatter } from 'loggings';
import Acc from './cmds/Acc';
export interface Command {
    name: string;
    desc: string;
    args?: string;
}

class KernelTerminal {
    private rl: readline.Interface;
    private commands: Record<string, (args: string[]) => Promise<void>> = {};
    public commandparams: Command[] = [];
    public game:InstanceType<typeof MtaManager> | undefined

    constructor() {
        this.rl = readline.createInterface({
            input: process.stdin,
            output: process.stdout
        });
    }
    public listCMDS() {
        return this.commandparams
    }

    public cmd(command: Command, handler: (args?: string[]) => Promise<void>) {
        this.commandparams.push(command)
        this.commands[command.name] = handler;
    }

    public timer() {
        const uptimeInSeconds = process.uptime();
        const days = Math.floor(uptimeInSeconds / 86400);
        const hours = Math.floor(uptimeInSeconds / 3600) % 24;
        const minutes = Math.floor(uptimeInSeconds / 60) % 60;
        const seconds = Math.floor(uptimeInSeconds) % 60;

        const processUptime = `${days > 0 ? days + "d " : ""}${hours > 0 ? hours + "h " : ""}${minutes > 0 ? minutes + "m " : ""
            }${seconds > 0 ? seconds + "s " : "0s"}`;

        return processUptime
    }
    public start(game:InstanceType<typeof MtaManager>) {
        this.game = game;
        this.rl.question(Formatter(["[Enter a].blue-b [command].green-b ([example].bold [help].magenta-b)[:].bold"]).message_csl, this.processUserInput.bind(this));

        this.rl.on('close', () => {
            core.log("[Finishing the].bold[Accelerator...].blue-b [See you later].bold")
            game.stop();
            process.exit(0);
        });
    }

    private async processUserInput(input: string) {
        const [command, ...args] = input.trim().split(' ');
        this.rl.pause();

        if (this.commands[command]) {
            core.log(`[Command].bold [${command}].blue-b [from accelerator executed...].bold`)
            await this.commands[command](args);
            core.log();
        } else {
            if (this.game && this.game.process !== null) {
                this.game.process.stdin?.write(input + '\n');
            } else {
                core.log('MTA not initiated for receiving this command.');
            }
        }
        this.rl.resume();
        this.rl.question(Formatter(["[Enter a].blue-b [command].green-b ([example].bold [help].magenta-b)[:].bold"]).message_csl, this.processUserInput.bind(this));
    }
}
export type Terminal = InstanceType<typeof KernelTerminal>;

export const terminal = new KernelTerminal();
Acc(terminal,terminal.game);
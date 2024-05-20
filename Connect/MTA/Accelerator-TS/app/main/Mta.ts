import { spawn } from "child_process";
import { mta } from "../utils/logger";

export class MtaManager {
    constructor(public cmd: string) {
        mta.log('[Mta].lime-b loaded [configurations].green-b.');
    }
    public process: ReturnType<typeof spawn> | null = null;

    public start(): void {
        if (this.process && !this.process.killed) {
            mta.log('[Mta].lime-b is already [running].green-b.');
            return;
        }

        this.process = spawn(this.cmd, {
            stdio: [process.stdin, process.stdout, process.stderr]
        });

         mta.log('[Mta].lime-b started.');
    }

    public stop(): void {
        if (this.process && !this.process.killed) {
            this.process.kill();
            mta.log('[Mta].lime-b stopped.');
        } else {
            mta.log('[Mta].lime-b is not running.');
        }
    }

    public restart(): void {
        this.stop();
        this.start();
    }
}
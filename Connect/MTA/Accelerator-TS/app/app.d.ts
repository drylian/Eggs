import { LoggingsLevel } from "loggings";

declare global {
    namespace NodeJS {
        interface ProcessEnv {
            RESOURCES_PATHS : string[];
            AUTO_UPDATE:boolean;
            LOGGER:LoggingsLevel;
            IP:string;
            PORT:number;
            NO_HTML:boolean;
        }
    }
}
export { }
/**
 * Logger of Application
 */
import { Loggings, LoggingsLevel } from "loggings";

export const core = new Loggings("Accelerator", "lime", {
    format:"[{title}]::[{status}] [{hours}:{minutes}:{seconds}].gray {message}",
    level:process.env.LOGGER as LoggingsLevel
})

export const mta = new Loggings("Mta","blue", {
    format:"[{title}]::[{status}] [{hours}:{minutes}:{seconds}].gray {message}",
    level:process.env.LOGGER as LoggingsLevel
})
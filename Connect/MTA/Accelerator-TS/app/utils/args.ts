interface ApplicationArgs {
    accelerator: string;
}
/**
 * Application args
 * @param args 
 * @returns 
 */
export function Argvs(args: string[]): ApplicationArgs {
    const options: Partial<ApplicationArgs> = {
        accelerator: '',
    };
    for (let i = 0; i < args.length; i++) {
        const arg = args[i];
        if (arg.startsWith('--')) {
            const optionName = arg.slice(2);
            if (i + 1 < args.length && !args[i + 1].startsWith('--')) {
                const optionValue = args[i + 1];
                switch (optionName) {
                    case 'accelerator':
                        options.accelerator = optionValue;
                        break;
                    default:
                        break;
                }
                i++;
            }
        }
    }
    return options as ApplicationArgs;
}
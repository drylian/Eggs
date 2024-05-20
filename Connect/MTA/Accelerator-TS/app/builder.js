const ChildProcess = require("child_process");
const esbuild = require("esbuild");
const { nodeExternalsPlugin } = require("esbuild-node-externals");
const fs = require("fs");
async function buildWithEsbuild() {
    if (fs.existsSync("./dist")) await fs.promises.rm("./dist", { recursive: true });
    if (fs.existsSync("./build")) await fs.promises.rm("./build", { recursive: true });

    /**
     * Makes dist js
     */
    ChildProcess.execSync("tsc --project ./tsconfig.json", { stdio: "inherit" });

    /**
     * Make one script 
     */
    await esbuild.build({
        bundle: true,
        // minify: true,
        entryPoints: {
            bundle: "dist/app/init-point.js",
        },
        outfile: 'dist/application.js',
        jsx: "transform",
        format: "cjs",
        logLevel: "debug",
        platform: "node",
        target: ["node20"],
        plugins: [nodeExternalsPlugin()],
    });
    const pkg = JSON.parse(await fs.promises.readFile("dist/package.json"));
    pkg.devDependencies = {}
    await fs.promises.writeFile("dist/package.json",JSON.stringify(pkg));
    ChildProcess.execSync("cd dist && npm i", { stdio: "inherit" });

    ChildProcess.execSync("pkg . --compress Brotli -d", { stdio: "inherit" });
    if (fs.existsSync("./dist")) await fs.promises.rm("./dist", { recursive:true});
}

// Chamada da função assíncrona
buildWithEsbuild().catch((error) => {
    console.error("Error during build:", error);
});

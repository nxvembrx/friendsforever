const esbuild = require("esbuild");
const { sassPlugin } = require("esbuild-sass-plugin");

const args = process.argv.slice(2);
const watch = args.includes("--watch");
const deploy = args.includes("--deploy");

const loader = {
  // Add loaders for images/fonts/etc, e.g. { '.svg': 'file' }
};

const plugins = [sassPlugin()];

let opts = {
  entryPoints: ["js/app.js"],
  bundle: true,
  target: "es2017",
  outdir: "../priv/static/assets",
  logLevel: "info",
  loader,
  plugins,
};

if (deploy) {
  opts = {
    ...opts,
    minify: true,
  };
}

if (watch) {
  opts = {
    ...opts,
    sourcemap: "inline",
  };
  esbuild
    .context(opts)
    .then((ctx) => {
      ctx.watch();
    })
    .catch((_error) => {
      process.exit(1);
    });
} else {
  esbuild.build(opts);
}

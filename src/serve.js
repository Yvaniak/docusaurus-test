import express from 'express'
import packagejson from '../package.json' with { type: "json" }


function main() {
  if (process.argv.includes("--help")) {
    console.log("Simply execute the serve.js file with node to launch the server,\nyou can give the port as an argument or the PORT environment variable.")
    return;
  }
  if (process.argv.includes("--version")) {
    console.log(packagejson.version)
    return;
  }

  const app = express()
  const port = process.argv[2] || process.env.PORT || 3000

  app.use(express.static('build'))

  app.listen(port, () => {
    console.log(`docusaurus-test listening on port ${port}`)
  })

}

main()
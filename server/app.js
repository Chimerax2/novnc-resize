const express = require('express')
const util = require('util');
const exec = util.promisify(require('child_process').exec);
const cors = require("cors")

const app = express()
const port = 6081

app.use(cors())
app.use(express.json())

async function resize(width, height) {
    console.log(`Resizing with width: ${width} & height: ${height}`)
    const { stdout, stderr } = await exec(`sh /home/chimera/server/scripts/windowresize.sh ${width} ${height}`);
    console.log('stdout:', stdout);
    console.log('stderr:', stderr);
}

app.get("/", (req, res) => {
    res.send("Working")
})

app.post('/resize', (req, res) => {
    resize(req.body.width, req.body.height)
    res.send('Success!')
})

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})
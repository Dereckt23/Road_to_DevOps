// server.js
const http = require('http');
const fs = require('fs');
const path = '/data/events.log';

function append(line) {
  fs.appendFileSync(path, line + '\n', 'utf8');
}

append(`[BOOT] app started at ${new Date().toISOString()}`);

const server = http.createServer((req, res) => {
  append(`[REQ] ${req.method} ${req.url} @ ${new Date().toISOString()}`);
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello from Compose hooks demo\n');
});

// Escuchamos en 3000
server.listen(3000, () => {
  console.log('Server listening on http://0.0.0.0:3000');
});

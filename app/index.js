const http = require('http');

const server = http.createServer((req, res) => {
  if (req.url === '/') {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Hello, world!\n');
  } else {
    res.writeHead(404);
    res.end('Not found\n');
  }
});

const port = process.env.PORT || 3000;
server.listen(port, () => {
  console.log(`Listening on ${port}`);
});

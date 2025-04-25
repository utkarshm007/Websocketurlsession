// const express = require('express')

// const webserver = express()
//  .use((req, res) =>
//    res.sendFile('/ws-client.html', { root: __dirname })
//  )
//  .listen(3000, () => console.log(`Listening on ${3000}`))

// const { WebSocketServer } = require('ws')
// const sockserver = new WebSocketServer({ port: 2048 })

// sockserver.on('connection', ws => {
//     console.log('New client connected!')
    
//     ws.send('connection established')
    
//     ws.on('close', () => console.log('Client has disconnected!'))
    
//     ws.on('message', data => {
//         sockserver.clients.forEach(client => {
//         console.log(`distributing message: ${data}`)
//         client.send(`${data}`)
//         })
//     })
    
//     ws.onerror = function () {
//         console.log('websocket error')
//     }
// }
// )


// const express = require('express');
// const app = express();
// const server = require('http').Server(app);
// const io = require('socket.io')(server);
// const { randomUUID } = require('crypto');

// const users = new Map();

// io.on('connection', (socket) => {
//   let username = socket.handshake.auth.username;

//   console.log('a user connected');

//   users.set(socket.id, username);

//   io.emit('receiveNewUser', username, Object.fromEntries(users));

//   socket.on('sendMessage', (message) => {
//     const username = users.get(socket.id);
//     io.emit('receiveMessage', randomUUID(), username, message);
//   });

//   socket.on('disconnect', () => {
//     console.log('user disconnected');
//     users.delete(socket.id);
//   });
// });

// server.listen(3000, () => {
//   console.log('listening on *:3000');
// });

const WebSocket = require('ws');
const wss = new WebSocket.Server({ port: 3000 });

const clients = new Set();

wss.on('connection', function connection(ws) {
  clients.add(ws);

  console.log('New client connected!');
  // const intervalId = setInterval(() => {
  //   if (ws.readyState === WebSocket.OPEN) {
  //     ws.send('streaming');
  //   }
  // }, 2000);

  ws.on('message', function incoming(message) {
    // Broadcast to all clients
    for (const client of clients) {
      if (client.readyState === WebSocket.OPEN) {
        client.send(message.toString());
      }
    }
  });

  ws.on('close', () => {
    clients.delete(ws);
  });
});

console.log('WebSocket server is running on ws://localhost:3000');

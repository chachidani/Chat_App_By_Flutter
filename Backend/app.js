const express = require('express');
var http = require('http');
const app = express();
const cors = require('cors');
const port = process.env.PORT || 5000;
const server = http.createServer(app);
const io = require('socket.io')(server
//     , {
//     cors: {
//         origin: '*',
//     }
// }
);

app.use(cors());
app.use(express.json());
var cliant = {};

io.on('connection', (socket) => {   
    console.log('a user connected');
    console.log(socket.id , " has connected");


    // socket.on('disconnect', () => {
    //     console.log('user disconnected');
    // });
    socket.on('/login', (id) => {
        console.log('id: ' + id);
        cliant[id] = socket;
        // console.log(cliant);
        // io.emit('chat message', msg);
    }

    );


    socket.on('message', (msg) => {
        console.log(msg);
        let targetId = msg.targetId;
        if (cliant[targetId]) cliant[targetId].emit('message', msg);

    });

}
);

server.listen(port,"0.0.0.0" ,() => {
    console.log(`Server running on port ${port}`);
});
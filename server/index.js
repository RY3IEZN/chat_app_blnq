/** @format */

const express = require("express");
const app = express();

// PORT
const PORT = process.env.PORT || 3006;

const server = app.listen(PORT, (req, res) => {
  console.log(`the server has started on ${PORT}`);
});

app.get("/", (req, res) => {
  res.send("you have reached the server");
  console.log("send the nigg bak");
});

// set up socketServer
const io = require("socket.io")(server);

io.on("connection", (socket) => {
  console.log("Connection successful with ", socket.id);
  socket.on("disconnect", () => {
    console.log("disconnectionaaaa successful with ", socket.id);
  });

  socket.on("message", (data) => {
    socket.broadcast.emit("message-recieve", data);
    console.log(data);
  });
});

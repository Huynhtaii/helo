require('dotenv').config();
import express from 'express';
import bodyParser from 'body-parser';
import path from 'path';
import configViewEngine from './configs/viewEngine';
import initWebRoutes from './Routes/web';
import Connection from './configs/connectDB';
import initAPIRoutes from './Routes/api';
import configCors from './configs/cors';
import cookieParser from 'cookie-parser';
import http from 'http';  // Thêm http để tạo server
const { Server } = require("socket.io");

let app = express();
let server = http.createServer(app); // Tạo server HTTP

// Cấu hình view engine
configViewEngine(app);

// Cấu hình CORS
configCors(app);

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cookieParser());

// Phục vụ tĩnh thư mục uploads
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Tạo instance Socket.IO với CORS
const io = new Server(server, {
   cors: {
      origin: process.env.REACT_URL || "http://localhost:3000",   
      methods: ["GET", "POST"],
      credentials: true
   }
});

// Lắng nghe sự kiện kết nối từ client
io.on("connection", (socket) => {
   console.log("🟢 User connected:", socket.id);

   socket.on("sendMessage", (data) => {
      console.log("📩 Message:", data);
      io.emit("receiveMessage", data);
   });

   socket.on("disconnect", () => {
      console.log("🔴 User disconnected:", socket.id);
   });
});

// Kết nối Database
Connection();

// Khởi tạo API và Web Routes
initAPIRoutes(app);
initWebRoutes(app);

// Lắng nghe server
let port = process.env.PORT || 6969;
server.listen(port, () => {
   console.log('🚀 Server is running at the port: ' + port);
});

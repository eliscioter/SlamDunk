import express from 'express'
import dotenv from 'dotenv'
import mongoose from 'mongoose'
import cors from 'cors'
import { Server } from 'socket.io'
import { createServer } from "http";

import { router as forumRouter } from './app/router/ForumRouter.js'
import { errorHandler } from './app/middlewares/Error.js'

dotenv.config()

const { PORT, CLIENT_ORIGIN, DB_URI } = process.env

const app = express()
const server = createServer(app);
const io = new Server(server, { 
    cors: {
        origin: CLIENT_ORIGIN,
        credentials: true
    },
})

app.use(express.json())
app.use(express.urlencoded({
    extended: true
}))
app.use(cors({
    origin: CLIENT_ORIGIN,
    credentials: true
}))

app.use('/api/data', forumRouter)
app.use(errorHandler)

server.listen(PORT, () => console.log(`Listening to port ${PORT}...`))
mongoose.connect(DB_URI, () => console.log(`Connected to the database...`))

io.on("connection", (socket) => {
    socket.on('forum', (msg, withDeletedForum) => {
        if(withDeletedForum) {
            socket.broadcast.emit('receive-new-forums', msg)
            return
        }
        socket.broadcast.emit('receive-forum', msg)
    })
    socket.on('join-thread', thread => {
        socket.join(thread)
    })
    socket.on('thread', (thread, msg, withDeletedComment) => {
        console.log(withDeletedComment)
        if(withDeletedComment) {
            socket.to(thread).emit('new-comment', msg)
            return
        }
        socket.to(thread).emit('comment', msg)
    })
    socket.on('disconnect', () => {
        console.log('user disconnected')
    })
})
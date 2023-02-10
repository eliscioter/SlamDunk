import express from 'express'
import cors from 'cors'
import dotenv from 'dotenv'
import mongoose from 'mongoose'
import { Server } from 'socket.io'
import { createServer } from "http";

dotenv.config()

import { errorHandler } from './app/middlewares/Error.js'

import { router as teamRouter } from './app/router/TeamRouter.js'

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

app.use("/api/data", teamRouter)
app.use(errorHandler)

server.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}...`))
mongoose.connect(DB_URI, () => console.log(`Connected to the database...`))

io.on("connection", (socket) => {
    socket.on('player', (players, id, withDeletedPlayer, withUpdatedPlayer) => {
        if(withDeletedPlayer) {
            socket.broadcast.emit('receive-new-players', players)
            return
        }
        if(withUpdatedPlayer) {
            socket.broadcast.emit('receive-updated-players', players)
            return
        }
        socket.broadcast.emit('receive-players', players, id)
    })
    socket.on('trait', (traits, id, withDeletedTrait, withUpdatedPlayer) => {
        if(withDeletedTrait) {
            socket.broadcast.emit('receive-new-traits', traits)
            return
        }
        if(withUpdatedPlayer) {
            socket.broadcast.emit('receive-updated-traits', traits)
            return
        }
        socket.broadcast.emit('receive-traits', traits, id)
    })

    socket.on('disconnect', () => {
        console.log('user disconnected')
    })
})
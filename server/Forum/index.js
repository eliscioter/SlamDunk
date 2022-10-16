import express from 'express'
import dotenv from 'dotenv'
import mongoose from 'mongoose'
import cors from 'cors'

import { router as forumRouter } from './app/router/ForumRouter.js'
import { errorHandler } from './app/middlewares/Error.js'

dotenv.config()

const { PORT, CLIENT_ORIGIN, DB_URI } = process.env

const app = express()

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

app.listen(PORT, () => console.log(`Listening to port ${PORT}...`))
mongoose.connect(DB_URI, () => console.log(`Connected to the database...`))
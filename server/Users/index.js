import express from 'express'
import dotenv from 'dotenv'
import mongoose from 'mongoose'
import cors from 'cors'

import { errorHandler } from './app/middlewares/Error.js'
import { router as userRouter } from './app/router/UserRouter.js'

dotenv.config()

const { DB_URI, CLIENT_ORIGIN, PORT } = process.env

const app = express()
app.use(express.json())
app.use(express.urlencoded({ 
    extended: true
}))
app.use(cors({ 
    origin: CLIENT_ORIGIN, 
    credentials: true
}))
app.use('/api/user', userRouter)
app.use(errorHandler)
app.listen(PORT, () => console.log(`listening to port ${PORT}...`))
mongoose.connect(DB_URI, () => console.log(`Connected to the database...`))
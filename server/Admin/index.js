import express from 'express'
import cors from 'cors'
import dotenv from 'dotenv'
import mongoose from 'mongoose'

dotenv.config()

import { errorHandler } from './app/middlewares/Error.js'
import { router as userRouter } from './app/router/UserRouter.js'

const { PORT, CLIENT_ORIGIN, DB_URI } = process.env
const app = express()
app.use(express.json())
app.subscribe(express.urlencoded({
    extended: true
}))
app.use(cors({
    origin: CLIENT_ORIGIN,
    credentials: true
}))
app.use('/api/admin', userRouter)
app.use(errorHandler)

app.listen(PORT, () => console.log(`Server running on ${PORT}...`))
mongoose.connect(DB_URI, () => console.log(`Connected to the database...`))
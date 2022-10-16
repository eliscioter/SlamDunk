import asyncHandler from 'express-async-handler'
import bcrypt from 'bcrypt'

import UserModel from '../models/UserModel.js'

export const createAdmin = asyncHandler(async (req, res) => {
    let { username, password, role } = req.body
    try {
        if(!username || !password || !role) return res.status(406).json({ error_message: 'Invalid or incomplete input' })
        username = username.toLowerCase().trim()
        const usernameExists = !!await UserModel.findOne({ username })
        if(usernameExists) return res.status(406).json({ error_message: 'Username already exists'})
        password = await bcrypt.hash(password, 10)

        const createdAdmin = await UserModel.create(
            { username, password, role }
        )
        res.status(201).json(createdAdmin)
    } catch (error) {
        console.log(error)
        res.sendStatus(400)
    }
})

export const signInAdmin = asyncHandler(async (req, res) => {
    let { username, password } = req.body
    try {
        if(!username || !password) return res.status(406).json({ error_message: 'Username and password are required' })
        username = username.toLowerCase().trim()
        const fetchAdmin = await UserModel.findOne({ username })
        const isVerified = await bcrypt.compare(password, fetchAdmin.password)
        if(!isVerified) return res.status(401).json({ error_message: 'Invalid credentials'})
        res.status(200).json({ message: 'Login successfull'})
    } catch (error) {
        
    }
})

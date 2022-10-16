import asyncHandler from 'express-async-handler'
import bcrypt from 'bcrypt'

import UserModel from '../models/UserModel.js'

export const createUser = asyncHandler(async (req, res) => {
    let { email, username, password, role } = req.body
    try {
        if(!email || !username || !password || !role) return res.status(406).json({ error_message: 'Invalid or incomplete input' })
        email = email.toLowerCase().trim()
        username = username.toLowerCase().trim()
        const emailExists = !!await UserModel.findOne({ email })
        const usernameExists = !!await UserModel.findOne({ username })
        if(emailExists || usernameExists) return res.status(406).json({ error_message: 'Email or username already exists'})
        password = await bcrypt.hash(password, 10)
        const createdUser = await UserModel.create(
            { email, username, password, role }
        )
        res.status(201).json(createdUser)
    } catch (error) {
        console.error(error)
        res.sendStatus(400)
    }
})

export const signInUser = asyncHandler(async (req, res) => {
    let { username, password } = req.body
    try {
        if(!username || !password) return res.status(406).json({ error_message: 'Username and password are required' })
        username = username.toLowerCase().trim()
        const fetchUser = await UserModel.findOne({ username })
        const isVerified = await bcrypt.compare(password, fetchUser.password)
        if(!isVerified) return res.status(401).json({ error_message: 'Invalid credentials'})
        res.status(200).json({ message: fetchUser.email})
    } catch (error) {
        
    }
})
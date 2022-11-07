import asyncHandler from 'express-async-handler'
import bcrypt from 'bcrypt'
import jwt from 'jsonwebtoken'
import dotenv from 'dotenv'

import UserModel from '../models/UserModel.js'
import { createToken } from './TokenController.js'
import TokenModel from '../models/TokenModel.js'

dotenv.config()

export const createUser = asyncHandler(async (req, res) => {
    let { email, username, password, role } = req.body
    try {
        if(!email || !username || !password || !role) return res.status(406).json({ message: 'Invalid or incomplete input' })
        email = email.toLowerCase().trim()
        username = username.toLowerCase().trim()
        const emailExists = !!await UserModel.findOne({ email })
        const usernameExists = !!await UserModel.findOne({ username })
        if(emailExists || usernameExists) return res.status(406).json({ message: 'Email or username already exists'})
        password = await bcrypt.hash(password, 10)
        const createdUser = await UserModel.create(
            { email, username, password, role }
        )
        res.status(201).json(createdUser)
    } catch (error) {
        res.status(400).json({ message: error.message })
    }
})

const { ACCESS_TOKEN, REFRESH_TOKEN } = process.env
export const signInUser = asyncHandler(async (req, res) => {
    let { username, password } = req.body
    try {
        if(!username || !password) return res.status(406).json({ message: 'Username and password are required' })
        username = username.toLowerCase().trim()
        const fetchUser = await UserModel.findOne({ username })
        if(!fetchUser) return res.status(401).json({ message: 'Invalid credentials'})
        const isVerified = await bcrypt.compare(password, fetchUser.password)
        if(!isVerified) return res.status(401).json({ message: 'Invalid credentials'})
        const roles = Object.values(fetchUser.role)

        const user = {
            "user_info": {
                "id": fetchUser.id,
                "name": username,
                "roles": roles
            }
        }
        const access_token = generateToken(user)
        const refresh_token = jwt.sign(user, REFRESH_TOKEN)
        createToken(refresh_token)
        res.status(200).json({access_token: access_token, refresh_token: refresh_token, username: fetchUser.username, role: roles})
    } catch (error) {
        res.status(400).json({message: error.message})
    }
})

export const generateToken = (user) => {
    return jwt.sign(user, ACCESS_TOKEN, { expiresIn: '30s' })
}

export const signOutUser = asyncHandler(async (req, res) => {
    const token = req.params.token
    try {
        if(!token) return res.status(404).json({message: `${token} not found`})
        const fetchToken = await TokenModel.findOne({ token: token }).deleteOne()
        res.status(204).json({message: 'Logged out'})
    } catch (error) {
        res.status(400).json({message: error.message})    
    }
})
import asyncHandler from 'express-async-handler'
import bcrypt from 'bcrypt'
import jwt from 'jsonwebtoken'
import dotenv from 'dotenv'

import UserModel from '../models/UserModel.js'
import { createToken } from '../controllers/TokenController.js'
import TokenModel from '../models/TokenModel.js'

dotenv.config()

export const createAdmin = asyncHandler(async (req, res) => {
    let { username, password, role } = req.body
    try {
        if(!username || !password || !role) return res.status(406).json({ message: 'Invalid or incomplete input' })
        username = username.toLowerCase().trim()
        role = role.toUpperCase().trim()
        const usernameExists = !!await UserModel.findOne({ username })
        if(usernameExists) return res.status(406).json({ message: 'Username already exists'})
        password = await bcrypt.hash(password, 10)

        const createdAdmin = await UserModel.create(
            { username, password, role }
        )
        res.status(201).json(createdAdmin)
    } catch (error) {
        res.status(400).json({ message: error.message })
    }
})

const { ACCESS_TOKEN, REFRESH_TOKEN } = process.env

export const signInAdmin = asyncHandler(async (req, res) => {
    let { username, password } = req.body
    try {
        if(!username || !password) return res.status(406).json({ message: 'Username and password are required' })
        username = username.toLowerCase().trim()
        const fetchAdmin = await UserModel.findOne({ username })
        if(!fetchAdmin) return res.status(404).json({ message: 'Wrong credentials'})
        const isVerified = await bcrypt.compare(password, fetchAdmin.password)
        if(!isVerified) return res.status(401).json({ message: 'Invalid username or password' })
        const roles = Object.values(fetchAdmin.role)
        const user = {
            "user_info": {
                "id": fetchAdmin.id,
                "name": username,
                "roles": roles
            }
        }
        const access_token = generateToken(user)
        const refresh_token = jwt.sign(user, REFRESH_TOKEN)
        createToken(refresh_token)
        res.status(200).json({access_token: access_token, refresh_token: refresh_token, message: `Welcome ${username}`})
    } catch (error) {
        res.status(401).json({ message: error.message })
    }
})

export const generateToken = (user) => {
    return jwt.sign(user, ACCESS_TOKEN, { expiresIn: '30s' })
}

export const signOutAdmin = asyncHandler(async (req, res) => {
    const token = req.params.token
    try {
        if(!token) return res.status(400).json({message: `Token is required`})
        const fetchToken = await TokenModel.findOne({ token: token }).deleteOne()
        if(!fetchToken) return res.status(404).json({message: `${token} is not found`})
        res.status(204).json({message: `Logged out`})
    } catch (error) {
        res.status(400).json({message: error.message})
    }
})

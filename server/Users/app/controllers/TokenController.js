import asyncHandler from 'express-async-handler'
import jwt from 'jsonwebtoken'
import dotenv from 'dotenv'

import TokenModel from '../models/TokenModel.js'
import { generateToken } from '../controllers/UserController.js'

dotenv.config()

export const createToken = asyncHandler(async(token) => {
    try {
        if(!token) return res.status(404).json({message: `${token} not found`})
        const createdToken = await TokenModel.create(
            { token }
        )
        if(!createdToken) return res.status(401).json({message: 'Invalid input'})
    } catch (error) {
        res.status(400).json({message: error.message})
    }
})


export const verifyToken = asyncHandler(async (req, res) => {
    const { REFRESH_TOKEN } = process.env
    const { token } = req.body
    try {
        if(!token) return res.status(404).json({message: `${token} not found`})
        // TODO: also change the admin token controller
        const fetchToken = await TokenModel.find({ token: new RegExp('^'+token+'$', "i")})
        if(!fetchToken) return res.status(401).json({message: 'Invalid credentials'})
        jwt.verify(token, REFRESH_TOKEN, (err, user) => {
            if(err) return res.status(403).json({message: err.message})
            const access_token = generateToken({
                "user_info": {
                    "id": user.user_info.id,
                    "name": user.user_info.name,
                    "roles": user.user_info.roles
                }
            })
            res.status(201).json(access_token)
        })
    } catch (error) {
        return res.status(400).json({message: error.message})
    }
})
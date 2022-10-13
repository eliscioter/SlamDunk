import asyncHandler from 'express-async-handler'
import bcrypt from 'bcrypt'

import UserModel from '../models/UserModel.js'

export const createUser = asyncHandler(async (req, res) => {
    let { email, username, password, role } = req.body
    try {
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
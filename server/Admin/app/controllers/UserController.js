import asyncHandler from 'express-async-handler'
import bcrypt from 'bcrypt'

import UserModel from '../models/UserModel.js'

export const createAdmin = asyncHandler(async (req, res) => {
    let { username, password, role } = req.body
    try {
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
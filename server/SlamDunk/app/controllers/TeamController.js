import asyncHandler from 'express-async-handler'

import TeamModel from '../models/TeamModel.js'

export const createTeam = asyncHandler(async (req, res) => {
    const { team_name, team_image_url } = req.body
    try {
        const createdTeam = await TeamModel.create(
            { team_name, team_image_url }
        )
        res.status(201).json(createdTeam)
    } catch (error) {
        res.sendStatus(400)
    }
    
})

export const fetchTeam = asyncHandler(async (req, res) => {
    try {
        const fetchedTeam = await TeamModel.find()
        res.status(200).json(fetchedTeam)
    } catch (error) {
        res.sendStatus(404)
    }
})


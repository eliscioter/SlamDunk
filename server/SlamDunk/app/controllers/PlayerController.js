import asyncHandler from "express-async-handler";

import PlayerModel from '../models/PlayerModel.js'

export const createPlayer = asyncHandler(async (req, res) => {
    const { 
        player: { 
            profile: { ...profile },
            attributes: { ...attributes },
            talents: { ...talents } 
        }, 
        tag
    } = req.body
    try {
        const createdPlayer = await PlayerModel.create(
            {
                player: { 
                    profile: { ...profile },
                    attributes: { ...attributes },
                    talents: { ...talents } 
                }, 
                tag
            }
        )
        res.status(201).json(createdPlayer)
    } catch (error) {
        res.sendStatus(400)
    }
})

export const fetchPlayer = asyncHandler(async (req, res) => {
    try {
        const fetchedPlayer = await PlayerModel.find()
        res.status(200).json(fetchedPlayer)
    } catch (error) {
        res.sendStatus(404)
        
    }
})
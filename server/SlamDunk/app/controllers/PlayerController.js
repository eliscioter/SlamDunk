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
        res.status(400).json({ error: error.message})
    }
})

export const fetchPlayers = asyncHandler(async (req, res) => {
    try {
        const fetchedPlayer = await PlayerModel.find().select('-createdAt -updatedAt -__v')
        res.status(200).json(fetchedPlayer)
    } catch (error) {
        res.status(404).json({ error: error.message })
        
    }
})

export const fetchPlayer = asyncHandler(async (req, res) => {
    const id = req.params.id
    try {
        if(! await idExist(id)) return res.status(404).json({ message: `${id} not found` })
        const fetchedPlayer = await PlayerModel.findById(id).select('-createdAt -updatedAt')
        res.status(200).json(fetchedPlayer)
    } catch (error) {
        res.status(400).json({ error: error.message })
    }
})

export const modifyPlayer = asyncHandler(async (req, res) => {
    const { 
        player: { 
            profile: { ...profile },
            attributes: { ...attributes },
            talents: { ...talents } 
        }, 
        tag
    } = req.body
    const id = req.params.id
    try {
        if(! await idExist(id)) return res.status(404).json({ message: `${id} not found` })
        const modifiedPlayer = await PlayerModel.findByIdAndUpdate(
            id,
            { $set: { 
            player: { 
                profile: { ...profile },
                attributes: { ...attributes },
                talents: { ...talents } 
            }, 
            tag
            } },
            { new: true }
        ).select('-id -createdAt -updatedAt -__v')
        res.status(200).json(modifiedPlayer)
    } catch (error) {
        res.status(400).json({ message: error.message})
    }
})

export const deletePlayer = asyncHandler(async (req, res) => {
    const id = req.params.id
    try {
        if(! await idExist(id)) return res.status(404).json({ message: `${id} not found` })
        const deletedPlayer = await PlayerModel.findByIdAndDelete(id)
        console.log(deletedPlayer)
        res.status(200).json({ message: `${id} deleted successfully` })
    } catch (error) {
        res.status(400).json({ message: error.message})
    }
})

async function idExist(id) {
    return !! await PlayerModel.findById(id)
}
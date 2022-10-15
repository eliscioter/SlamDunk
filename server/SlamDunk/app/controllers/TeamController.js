import asyncHandler from 'express-async-handler'

import TeamModel from '../models/TeamModel.js'

export const createTeam = asyncHandler(async (req, res) => {
    let { team_name, team_image_url } = req.body
    try {
        if(!team_name || !team_image_url) return res.status(406).json({error_message: "Name and image url is required"})
        team_name = team_name.toLowerCase()
        const teamExist = !!await TeamModel.findOne({ team_name }) 
        if(teamExist) return res.status(406).json({error_message: "Team already exists"})
        const createdTeam = await TeamModel.create(
            { team_name, team_image_url }
        )
        res.status(201).json(createdTeam)
    } catch (error) {
        res.status(400).json({ error: error.message })
    }
    
})

export const fetchTeams = asyncHandler(async (req, res) => {
    try {
        const fetchedTeams = await TeamModel.find().select('-id -createdAt -updatedAt -__v')
        res.status(200).json(fetchedTeams)
    } catch (error) {
        res.status(400).json({ error: error.message })
    }
})

export const fetchTeam = asyncHandler(async (req, res) => {
    try {
        const id = req.params.id
        if (! await idExists(id)) return res.status(404).json({ message: `${id} not found`})
        const fetchedTeam = await TeamModel.findById(id).select('-id -createdAt -updatedAt -__v')
        res.status(200).json(fetchedTeam)
    } catch (error) {
        res.status(400).json({ error: error.message })
    }
})

export const modifyTeam = asyncHandler(async (req, res) => {
    const { team_name, team_image_url } = req.body
    const id = req.params.id
    try {
        if(! await idExists(id)) return res.status(404).json({ message: `${id} not found` })
        const modifiedTeam = await TeamModel.findByIdAndUpdate(
            id,
            { $set: { team_name, team_image_url } },
            { new: true }
        ).select('-id -createdAt -updatedAt -__v')
        res.status(200).json(modifiedTeam)
    } catch (error) {
        res.status(400).json({ error: error.message })
    }
})

export const deleteTeam = asyncHandler(async (req, res) => {
    try {
        const id = req.params.id
        if(! await idExists(id)) return res.status(404).json({error_message: `${id} not found`})
        const deletedTeam = await TeamModel.findByIdAndDelete(id).select('-id -createdAt -updatedAt -__v')
        res.status(200).json({ message: `${deletedTeam.team_name} is deleted successfully` })
    } catch (error) {
        res.status(400).json({ error: error.message })
    }
})

async function idExists(id) {
    return !!await TeamModel.findById(id)
}
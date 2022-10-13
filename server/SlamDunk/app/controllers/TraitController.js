import asyncHandler from "express-async-handler";

import TraitModel from '../models/TraitModel.js'

export const createTrait = asyncHandler(async (req, res) => {
    const { name, image_url, description, tag } = req.body
    
    try {
        const createdTrait = await TraitModel.create(
            { name, image_url, description, tag }
        )
        res.status(201).json(createdTrait)
    } catch (e) {
        res.sendStatus(400)
    }
})

export const fetchTraits = asyncHandler(async (req, res) => {
    try {
        const fetchedTraits = await TraitModel.find()
        res.status(200).json(fetchedTraits)
    } catch (error) {
        res.sendStatus(404)
    }
})
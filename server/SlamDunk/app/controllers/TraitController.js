import asyncHandler from "express-async-handler";

import TraitModel from '../models/TraitModel.js'

export const createTrait = asyncHandler(async (req, res) => {
    const { name, image_url, description, tag } = req.body
    
    try {
        if(!name || !image_url, !description || !tag) return res.status(404).json({message: 'Incomplete or invalid input'})
        const traitExists = !!await TraitModel.findOne({ name })
        if(traitExists) return res.status(400).json({message: `${name} already exists`})
        const createdTrait = await TraitModel.create(
            { name, image_url, description, tag }
        )
        res.status(201).json(createdTrait)
    } catch (error) {
        res.status(400).json({error: error.message})
    }
})

export const fetchTraits = asyncHandler(async (req, res) => {
    try {
        const fetchedTraits = await TraitModel.find().select('-createdAt -updatedAt -__v')
        res.status(200).json(fetchedTraits)
    } catch (error) {
        res.status(400).json({error: error.message})
    }
})

export const fetchCategoryTraits = asyncHandler(async (req, res) => {
    const category = req.params.category
    try {
        if(!category) return res.status(404).json({message: `${category} not found`})
        const fetchedCategoryTraits = await TraitModel.find({ tag: category }).select('-createdAt -updatedAt -__v')
        if(!fetchedCategoryTraits?.length > 0) return res.status(404).json({message: `${category} does not exist`})
        res.status(200).json(fetchedCategoryTraits)
    } catch (error) {
        res.status(400).json({error: error.message})
    }
})

export const fetchTrait = asyncHandler(async (req, res) => {
    const id = req.params.id
    try {
        if(! await idExists(id)) return res.status(404).json({ message: `${id} not found` })
        const fetchedTrait = await TraitModel.findById(id).select('-createdAt -updatedAt -__v')
        res.status(200).json(fetchedTrait)
    } catch (error) {
        res.status(400).json({error: error.message})
    }
})
export const modifyTrait = asyncHandler(async (req, res) => {
    const { name, image_url, description, tag } = req.body
    const id = req.params.id
    try {
        if(! await idExists(id)) return res.status(404).json({ message: `${id} not found` })
        if(!name || !image_url || !description || !tag) return res.status(400).json({ message: 'Invalid or incomplete input'})
        const modifiedTrait = await TraitModel.findByIdAndUpdate(
            id,
            { $set: { name, image_url, description, tag } },
            { new: true }
        ).select('-createdAt -updatedAt -__v')
        res.status(200).json(modifiedTrait)
    } catch (error) {
        res.status(400).json({ error: error.message })
    }
})

export const deleteTrait = asyncHandler(async (req, res) => {
    const id = req.params.id
    try {
        if(! await idExists(id)) return res.status(404).json({ message: `${id} not found` })
        const deletedTrait = await TraitModel.findByIdAndDelete(id)
        res.status(200).json({message: `${deletedTrait.name} is successfully deleted` })
    } catch (error) {
        res.status(400).json({ error: error.message })
    }
})

async function idExists(id) {
    return !! await TraitModel.findById(id)
}
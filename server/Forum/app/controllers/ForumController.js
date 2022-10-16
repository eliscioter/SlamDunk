import asyncHandler from 'express-async-handler'

import ForumModel from '../models/ForumModel.js'

export const createForum = asyncHandler(async (req, res) => {
    const { title, primary_author, body: [{ ...content }] } = req.body
    try {
        const createdForum = await ForumModel.create(
            { 
                title,
                primary_author,
                body: [{ ...content }]
            }
        )
        res.status(201).json(createdForum)
    } catch (error) {
        res.status(400).json({ error_message: error.message })
    }
})

export const replyForum = asyncHandler(async (req, res) => {
    const id = req.params.id
    const { body: {author, content} } = req.body
    try {
        if(!idExists(id)) return res.status(404).json({ error_message: 'ID not found'})
        const repliedForum = await ForumModel.findByIdAndUpdate(
            id,
            { $push: {body: { author: author, content: content }} },
            { new: true }
        )
        res.status(200).json(repliedForum)
    } catch (error) {
        res.status(400).json({ error_message: error.message })
    }
})

export const fetchForums = asyncHandler(async (req, res) => {
    try {
        const fetchedForums = await ForumModel.find().select('-body -__v')
        if(!fetchedForums || !fetchedForums?.length > 0) return res.status(404).json({ error_message: 'No forums found' })
        res.status(200).json(fetchedForums)
    } catch (error) {
        res.status(400).json({ error_message: error.message })
    }    
})

export const fetchForum = asyncHandler(async (req, res) => {
    try {
        const id = req.params.id
        if(! await idExists(id)) return res.status(404).json({ error_message: `Forum not found`})
        const fetchedForum = await ForumModel.findById(id).select(' -__v')
        res.status(200).json(fetchedForum)
    } catch (error) {
        res.status(400).json({ error_message: error.message })
    }
})

export const deleteForum = asyncHandler(async (req, res) => {
    try {
        const id = req.params.id
        if(! await idExists(id)) return res.status(404).json({ error_message: 'Forum not found' })
        const deletedForum = await ForumModel.findByIdAndUpdate(id)
        res.status(200).json({ message: "Forum successfully deleted"})
    } catch (error) {
        res.status(400).json({ error_message: error.message })
    }
})

export const deleteMessage = asyncHandler(async (req, res) => {
    try {
        const id = req.params.id
        const messageID = req.params.message
        if(! await idExists(id) || !messageID) return res.status(404).json({ error_message: `message not found`})
        const messageExists = await ForumModel.findOne({ _id: id }).select({ body: { $elemMatch: { _id: messageID } } })
        if(!messageExists.body?.length > 0) return res.status(404).json({ error_message: '404'})
        const deletedMessage = await ForumModel.findByIdAndUpdate(
            id,
            { $pull: { body: { _id: messageID } } }
        )
        res.status(200).json({ message: "Message deleted"})
    } catch (error) {
        res.status(400).json({ error_message: error.message })
    }
})

async function idExists(id) {
    return !! await ForumModel.findById(id)
}
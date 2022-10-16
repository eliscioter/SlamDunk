import express from 'express'

import { createForum, replyForum, fetchForums, fetchForum, deleteForum, deleteMessage } from '../controllers/ForumController.js'

export const router = express.Router()

router.post('/store', createForum)

router.put('/message/:id', replyForum)

router.delete('/forum/delete/:id', deleteForum)
router.delete('/message/delete/:id/:message', deleteMessage)

router.get('/forums', fetchForums)
router.get('/forum/:id', fetchForum)
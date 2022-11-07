import express from 'express'

import { createForum, replyForum, fetchForums, fetchForum, deleteForum, deleteMessage } from '../controllers/ForumController.js'
import { authenticateToken } from '../middlewares/Authenticate.js'
import { verifyRole } from '../middlewares/VerifyRole.js'
import { ROLE } from '../../config/Roles.js'
export const router = express.Router()

const mod = [authenticateToken, verifyRole(ROLE.EDITOR, ROLE.MODERATOR)]
const all = [authenticateToken, verifyRole(ROLE.EDITOR, ROLE.MODERATOR, ROLE.MEMBER)]

router.post('/store', all, createForum)

router.put('/message/:id',all, replyForum)

router.delete('/forum/delete/:id', mod, deleteForum)
router.delete('/message/delete/:id/:message', mod, deleteMessage)

router.get('/forums', fetchForums)
router.get('/forum/:id', all, fetchForum)
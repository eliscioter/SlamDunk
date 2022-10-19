import express from 'express'

import { createForum, replyForum, fetchForums, fetchForum, deleteForum, deleteMessage } from '../controllers/ForumController.js'
import { authenticateToken } from '../middlewares/Authenticate.js'
import { verifyRole } from '../middlewares/VerifyRole.js'
import { ROLE } from '../../config/Roles.js'
export const router = express.Router()

const admin = [authenticateToken, verifyRole(ROLE.EDITOR)]
const mod = [authenticateToken, verifyRole(ROLE.MODERATOR)]
const member = [authenticateToken, verifyRole(ROLE.EDITOR, ROLE.MODERATOR, ROLE.MEMBER)]

router.post('/store', admin || mod || member ,createForum)

router.put('/message/:id', admin || mod || member, replyForum)

router.delete('/forum/delete/:id', mod, deleteForum)
router.delete('/message/delete/:id/:message', mod, deleteMessage)

router.get('/forums', member, fetchForums)
router.get('/forum/:id', member, fetchForum)
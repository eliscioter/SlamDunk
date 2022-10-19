import express from 'express'

import { createAdmin, signInAdmin, signOutAdmin } from '../controllers/UserController.js'
import { verifyToken } from '../controllers/TokenController.js'
export const router = express.Router()

router.post('/store', createAdmin)
router.post('/login', signInAdmin)
router.post('/token', verifyToken)
router.delete('/logout/:token', signOutAdmin)
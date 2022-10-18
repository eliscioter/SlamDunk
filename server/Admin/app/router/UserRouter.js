import express from 'express'

import { createAdmin, signInAdmin, signOutAdmin } from '../controllers/UserController.js'

export const router = express.Router()

router.post('/store', createAdmin)
router.post('/login', signInAdmin)
router.delete('/logout/:token', signOutAdmin)
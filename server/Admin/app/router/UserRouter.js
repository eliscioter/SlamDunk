import express from 'express'

import { createAdmin, signInAdmin } from '../controllers/UserController.js'

export const router = express.Router()

router.post('/store', createAdmin)
router.post('/login', signInAdmin)
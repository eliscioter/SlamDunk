import express from 'express'

import { createAdmin } from '../controllers/UserController.js'

export const router = express.Router()

router.post('/store', createAdmin)
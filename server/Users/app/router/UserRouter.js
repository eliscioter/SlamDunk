import express from 'express';

import { createUser, signInUser } from '../controllers/UserController.js'

export const router = express.Router()

router.post('/store', createUser)
router.post('/login', signInUser)
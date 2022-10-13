import express from 'express';

import { createUser } from '../controllers/UserController.js'

export const router = express.Router()

router.post('/store', createUser)
import express from 'express';

import { createUser, signInUser, signOutUser } from '../controllers/UserController.js'
import { verifyToken } from '../controllers/TokenController.js';
export const router = express.Router()

router.post('/store', createUser)
router.post('/login', signInUser)
router.post('/token', verifyToken)
router.delete('/logout/:token', signOutUser)
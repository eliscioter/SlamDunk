import express from 'express'

import { createTeam, fetchTeam } from '../controllers/TeamController.js'
import { createPlayer, fetchPlayer } from '../controllers/PlayerController.js'
import { createTrait, fetchTraits } from '../controllers/TraitController.js'

export const router = express.Router()

router.post('/store/team', createTeam)
router.post('/store/player', createPlayer)
router.post('/store/trait', createTrait)

router.get('/team', fetchTeam)
router.get('/players', fetchPlayer)
router.get('/traits', fetchTraits)

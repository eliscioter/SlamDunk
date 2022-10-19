import express from 'express'

import { createTeam, fetchTeams, fetchTeam, modifyTeam, deleteTeam } from '../controllers/TeamController.js'
import { createPlayer, fetchPlayers, fetchPlayer, fetchTeamPlayers, modifyPlayer, deletePlayer } from '../controllers/PlayerController.js'
import { createTrait, fetchTraits, fetchTrait, fetchCategoryTraits, modifyTrait, deleteTrait } from '../controllers/TraitController.js'
import { authenticateToken } from '../middlewares/Authenticate.js'
import { verifyRole } from '../middlewares/VerifyRole.js'
import { ROLE } from '../../config/Roles.js'

export const router = express.Router()

const admin = [authenticateToken, verifyRole(ROLE.EDITOR)]

router.post('/store/team', admin, createTeam)
router.post('/store/player', admin, createPlayer)
router.post('/store/trait', admin, createTrait)

router.get('/teams', fetchTeams)
router.get('/team/:id', fetchTeam)
router.get('/players', fetchPlayers)
router.get('/player/:id', fetchPlayer)
router.get('/team/players/:team', fetchTeamPlayers)
router.get('/traits', fetchTraits)
router.get('/trait/:id', fetchTrait)
router.get('/category/:category', fetchCategoryTraits)

router.put('/team/modify/:id', admin, modifyTeam)
router.put('/player/modify/:id', admin, modifyPlayer)
router.put('/trait/modify/:id', admin, modifyTrait)

router.delete('/team/delete/:id', admin, deleteTeam)
router.delete('/player/delete/:id', admin, deletePlayer)
router.delete('/trait/delete/:id', admin, deleteTrait)
import express from 'express'

import { createTeam, fetchTeams, fetchTeam, modifyTeam, deleteTeam } from '../controllers/TeamController.js'
import { createPlayer, fetchPlayers, fetchPlayer, fetchTeamPlayers, modifyPlayer, deletePlayer } from '../controllers/PlayerController.js'
import { createTrait, fetchTraits, fetchTrait, fetchCategoryTraits, modifyTrait, deleteTrait } from '../controllers/TraitController.js'

export const router = express.Router()

router.post('/store/team', createTeam)
router.post('/store/player', createPlayer)
router.post('/store/trait', createTrait)

router.get('/teams', fetchTeams)
router.get('/team/:id', fetchTeam)
router.get('/players', fetchPlayers)
router.get('/player/:id', fetchPlayer)
router.get('/team/players/:team', fetchTeamPlayers)
router.get('/traits', fetchTraits)
router.get('/trait/:id', fetchTrait)
router.get('/category/:category', fetchCategoryTraits)

router.put('/team/modify/:id', modifyTeam)
router.put('/player/modify/:id', modifyPlayer)
router.put('/trait/modify/:id', modifyTrait)

router.delete('/team/delete/:id', deleteTeam)
router.delete('/player/delete/:id', deletePlayer)
router.delete('/trait/delete/:id', deleteTrait)
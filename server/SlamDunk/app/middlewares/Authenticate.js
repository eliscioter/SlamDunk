import dotenv from 'dotenv'
import jwt from 'jsonwebtoken'

dotenv.config()

const { ACCESS_TOKEN, REFRESH_TOKEN } = process.env

export async function authenticateToken(req, res, next) {
    try {
        const header_token = await req.headers['authorization']
        if (!header_token) return res.status(401).json({ message: 'Token undefined'})
        const token = header_token.split(' ')[1]
        jwt.verify(token, ACCESS_TOKEN, (err, decoded) => {
            if(err) return res.status(403).json({ message: err.message })
            req.id = decoded.user_info.id
            req.user = decoded.user_info.name
            req.roles = decoded.user_info.roles
        })
        next()
    } catch (error) {
        res.status(403).json({ message: error.message })
    }
}
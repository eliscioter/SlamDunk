import dotenv from 'dotenv'

dotenv.config()
const { NODE_ENV } = process.env

export const errorHandler = (err, req, res, next) => {
    try {
        next()
    } catch (error) {
        if(err) {
            res.status(res.statusCode).json(
                {
                    message: err.message,
                    stack: NODE_ENV === 'DEVELOPEMT' ? err.stack : undefined
                }
            )
            return
        }
    }
}
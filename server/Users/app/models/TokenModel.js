import mongoose from 'mongoose'

const UserToken = new mongoose.Schema(
    {
        token: {
            type: String,
            required: true
        }
    }
)

export default mongoose.model('UserToken', UserToken)
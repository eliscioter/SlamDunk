import mongoose from 'mongoose'

const AdminToken = new mongoose.Schema(
    {
        token: {
            type: String,
            required: true
        }
    }, { timestamps: true }
)

export default mongoose.model('AdminToken', AdminToken)
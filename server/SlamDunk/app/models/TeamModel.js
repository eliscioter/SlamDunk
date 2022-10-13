import mongoose from 'mongoose'

const Team = new mongoose.Schema(
    {
        team_name: { 
            type: String,
            required: true
        },
        team_image_url: { 
            type: String,
            required: true
        }
    }, { timestamps: true }
)

export default mongoose.model("Team", Team)
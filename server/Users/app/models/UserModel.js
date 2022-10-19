import mongoose from "mongoose"

const Member = new mongoose.Schema(
    {
        email: { 
            type: String,
            required: true
        },
        username: { 
            type: String, 
            equired: true
        },
        password: { 
            type: String, 
            required: true
        },
        role: {
            type: [String], 
            required: true
        }
    }, { timestamps: true }
)

export default mongoose.model("Member", Member)
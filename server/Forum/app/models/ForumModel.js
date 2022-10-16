import mongoose from 'mongoose'

const Forum = new mongoose.Schema(
    {
        title: { 
            type: String,
            required: true
        },
        primary_author: { 
            type: String,
            required: true
        },
        body: [
            {
                author: {
                    type: String,
                    required: true
                },
                content: { 
                    type: String,
                    required: true
                }
            }, { timestamps: true }
        ],
        
    }, { timestamps: true }
)

export default mongoose.model("Forum", Forum)
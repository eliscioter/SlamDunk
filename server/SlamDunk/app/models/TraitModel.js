import mongoose from "mongoose";

const Trait = new mongoose.Schema(
    { 
        name: {
            type: String,
            required: true
        },
        image_url: {
            type: String,
            required: true
        },
        description: {
            type: String,
            required: true
        },
        tag: {
            type: String,
            required: true
        }
    }, { timestamps: true }
)

export default mongoose.model("Traits", Trait)
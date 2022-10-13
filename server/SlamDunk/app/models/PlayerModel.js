import mongoose from 'mongoose'

const Snippet = new mongoose.Schema(
    {
        name: { 
            type: String,
            required: true
        },
        description: {
            type: String,
            required: true
        },
        talent_image_url: {
            type: String,
            required: true
        }
    }
)
const Player = new mongoose.Schema(
    {
        player: {
            
            profile: { 
                player_name: {
                    first_name: { 
                        type: String,
                        required: true
                    },
                    last_name: {
                        type: String,
                        required: true
                    }
                },
                image_url: {
                    type: String,
                    required: true
                },
                position: {
                    abbr: {
                        type: String,
                        required: true
                    },
                    full_version: {
                        type: String,
                        required: true
                    }
                },
                school: {
                    type: String,
                    required: true
                },
                height: {
                    type: Number,
                    required: true
                },
                weight: {
                    type: Number,
                    required: true
                },
                description: {
                    type: String,
                    required: true
                },
            },
            attributes: {
                general: {
                    control: {
                        type: Number,
                        required: true
                    },
                    strength: {
                        type: Number,
                        required: true
                    },
                    res: {
                        type: Number,
                        required: true
                    },
                    jump: {
                        type: Number,
                        required: true
                    },
                    run: {
                        type: Number,
                        required: true
                    },
                    dribble: {
                        type: Number,
                        required: true
                    }
                },
                offense: {
                    close: {
                        type: Number,
                        required: true
                    },
                    middle: {
                        type: Number,
                        required: true
                    },
                    three_pointer: {
                        type: Number,
                        required: true
                    },
                    dunk: {
                        type: Number,
                        required: true
                    },
                    layup: {
                        type: Number,
                        required: true
                    }
                },
                defense: {
                    reb: {
                        type: Number,
                        required: true
                    },
                    blk: {
                        type: Number,
                        required: true
                    },
                    jam: {
                        type: Number,
                        required: true
                    },
                    stl: {
                        type: Number,
                        required: true
                    },
                }
            },
            talents: {
                talent1: {
                    type: Snippet,
                    required: true
                },
                talent2: {
                    type: Snippet,
                    required: true
                },
                talent3: {
                    type: Snippet,
                    required: true
                },
                talent4: {
                    type: Snippet,
                    required: true
                },
                talent5: {
                    type: Snippet,
                    required: true
                },
                talent6: {
                    type: Snippet,
                    required: true
                },
            }
        
        },
        tag: {
            type: String,
            required: true
        }
    },{ timestamps: true }
)

export default mongoose.model("Player", Player)
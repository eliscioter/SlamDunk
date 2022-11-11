export interface Player {
    _id?: string;
    player: {
        profile: { 
            player_name: {
                first_name: string
                last_name: string
            },
            image_url: string
            position: {
                abbr: string
                full_version: string
            },
            school: string
            height: number
            weight: number
            description: string
        },
        attributes: {
            general: {
                control: number
                strength: number
                res: number
                jump: number
                run: number
                dribble: number
            },
            offense: {
                close: number
                middle: number
                three_pointer: number
                dunk: number
                layup: number
            },
            defense: {
                reb: number
                blk: number
                jam: number
                stl: number
            }
        },
        talents: {
            talent1: {
                name: string
                description: string
                talent_image_url: string
            },
            talent2: {
                name: string
                description: string
                talent_image_url: string
            },
            talent3: {
                name: string
                description: string
                talent_image_url: string
            },
            talent4: {
                name: string
                description: string
                talent_image_url: string
            },
            talent5: {
                name: string
                description: string
                talent_image_url: string
            },
            talent6: {
                name: string
                description: string
                talent_image_url: string
            },
        }
        
    },
    tag: string
}

export interface Talent {
    name: string
    description: string
    talent_image_url: string
    
}
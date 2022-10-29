export interface Member {
    id?: string
    email: string;
    username: string
    password: string
    role: [string]
    access_token?: string
    refresh_token?: string
}
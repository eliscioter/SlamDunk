export interface CreateForum {
    title: string,
    primary_author: string,
    body: [
        { 
            author: string,
            content: string
        }
    ]
}
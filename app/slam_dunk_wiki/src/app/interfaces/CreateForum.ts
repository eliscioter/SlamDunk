export interface CreateForum {
    _id?: string;
    title: string,
    primary_author: string,
    body: [
        { 
            author: string,
            content: string
        }
    ]
}
import { Injectable } from '@angular/core';
import {  HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs'

import { Forum } from '../../interfaces/Forum';
import { CreateForum } from '../../interfaces/CreateForum';
import { Body } from '../../interfaces/ForumBody';
import { Comment } from '../../interfaces/ForumComment';

@Injectable({
  providedIn: 'root'
})
export class ForumService {

  private api_url = 'https://slamdunkforum.onrender.com/api/data'
  // private api_url = 'http://localhost:5003/api/data'

  constructor(private http: HttpClient) { }

  getForums(): Observable<Forum[]> {
    return this.http.get<Forum[]>(`${this.api_url}/forums`)
  }

  getForum(id: string): Observable<Body> {
    return this.http.get<Body>(`${this.api_url}/forum/${id}`)
  }

  createForum(forum: CreateForum): Observable<CreateForum> {
    return this.http.post<CreateForum>(`${this.api_url}/store`, forum)
  }

  commentForum(comment: Comment, id: string): Observable<Comment> {
    return this.http.put<Comment>(`${this.api_url}/message/${id}`, comment)
  }

  deleteForum(forum: Forum): Observable<Forum> {
    return this.http.delete<Forum>(`${this.api_url}/forum/delete/${forum._id}`)
  }

  deleteComment(id: string, forum: Body): Observable<Body> {
    return this.http.delete<Body>(`${this.api_url}/message/delete/${id}/${forum._id}`)
  }

}

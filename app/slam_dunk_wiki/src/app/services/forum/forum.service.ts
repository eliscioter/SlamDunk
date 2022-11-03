import { Injectable } from '@angular/core';
import {  HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs'

import { Forum } from '../../interfaces/Forum';
import { CreateForum } from '../../interfaces/CreateForum';
import { Body } from '../../interfaces/ForumBody';

const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json'
  })
}

@Injectable({
  providedIn: 'root'
})
export class ForumService {

  private api_url = 'http://localhost:5003/api/data'

  constructor(private http: HttpClient) { }

  getForums(): Observable<Forum[]> {
    return this.http.get<Forum[]>(`${this.api_url}/forums`)
  }

  getForum(id: string): Observable<Body> {
    return this.http.get<Body>(`${this.api_url}/forum/${id}`)
  }

  createForum(forum: CreateForum): Observable<CreateForum> {
    return this.http.post<CreateForum>(`${this.api_url}/store`, forum, httpOptions)
  }

}
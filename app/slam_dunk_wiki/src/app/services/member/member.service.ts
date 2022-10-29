import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http'
import { map, Observable } from 'rxjs'

import { Member } from '../../interfaces/Member';

const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json'
  })
}

@Injectable({
  providedIn: 'root'
})

export class MemberService {

  private api_url = 'http://localhost:5002/api/user'

  

  constructor(private http: HttpClient) { }

  register(member: Member): Observable<Member> {
    return this.http.post<Member>(`${this.api_url}/store`, member, httpOptions)
  }

  isLoggedIn(): boolean {
    return true
  }
}

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

  auth(member: Member): Observable<Member> {
    return this.http.post<Member>(`${this.api_url}/login`, member, httpOptions).pipe(map(res => {
      
      const { access_token, refresh_token } = res

      localStorage.setItem('access_token', JSON.stringify(access_token))
      localStorage.setItem('refresh_token', JSON.stringify(refresh_token))
      
      return res
    }))
  }

  isLoggedIn(): boolean {
    let authToken = localStorage.getItem('access_token');
    return authToken !== null ? true : false;
  }

  signOut() {
    
  }
}
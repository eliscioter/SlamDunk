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
      const { access_token, refresh_token, username, role } = res
      localStorage.setItem('role', JSON.stringify(role));
      localStorage.setItem('username', JSON.stringify(username))
      localStorage.setItem('access_token', JSON.stringify(access_token))
      localStorage.setItem('refresh_token', JSON.stringify(refresh_token))
      return res
    }))
  }
  
  isLoggedIn(): boolean {
    const authToken = !!localStorage.getItem('access_token');

    return authToken ? true : false;
  }

  getUsername(): string {
    return null || JSON.parse(localStorage.getItem('username') as string)
  }

  getToken(): string {
    return localStorage.getItem('access_token') as string
  }

  getRefreshToken(): string {
    return localStorage.getItem('refresh_token') as string
  }

  getRole(): string {
    return localStorage.getItem('role') as string
  }

  signOut(token: string): Observable<string> {
    localStorage.clear()
    return this.http.delete<string>(`${this.api_url}/logout/${JSON.parse(token)}`)
  }
}

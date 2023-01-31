import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { map, Observable } from 'rxjs'

import { Admin } from 'src/app/interfaces/admin/Admin';

const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json'
  })
}
@Injectable({
  providedIn: 'root'
})
export class AdminService {

  private api_url = 'https://slamdunkadmin.onrender.com/api/admin'
  // private api_url = 'http://localhost:5001/api/admin'

  constructor(private http: HttpClient) { }

  auth(user: Admin): Observable<Admin> {
    return this.http.post<Admin>(`${this.api_url}/login`, user, httpOptions).pipe(map( res => {
      const { access_token, refresh_token, username, role } = res
      localStorage.setItem('role', JSON.stringify(role));
      localStorage.setItem('username', username)
      localStorage.setItem('access_token', JSON.stringify(access_token))
      localStorage.setItem('refresh_token', JSON.stringify(refresh_token))
      return res
    }))
  }

  storeURL(url: string): void {
    localStorage.setItem('route', url)
  }

  getURL(): string {
    const route = localStorage.getItem('route') as string
    return route
  }

  logout(token: string): Observable<string> {
    localStorage.clear()
    return this.http.delete<string>(`${this.api_url}/logout/${JSON.parse(token)}`)
  }

  
}

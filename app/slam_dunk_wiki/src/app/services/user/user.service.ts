import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor() { }

  isLoggedIn(): boolean {
    const authToken = !!localStorage.getItem('access_token');
    return authToken ? true : false;
  }

  getUsername(): string {
    return null || localStorage.getItem('username') as string
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
}

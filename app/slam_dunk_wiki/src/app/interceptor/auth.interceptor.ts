import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
  HttpErrorResponse,
  HttpClient
} from '@angular/common/http';
import { Observable, catchError, switchMap, throwError } from 'rxjs';

import { Token } from '../interfaces/Token'
import { MemberService } from '../services/member/member.service';
import { AdminService } from '../services/admin/admin.service';
import { UserService } from '../services/user/user.service';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {

  constructor(private memberService: MemberService, private http: HttpClient, private admin: AdminService, private userService: UserService) {}

  intercept(request: HttpRequest<Token>, next: HttpHandler): Observable<HttpEvent<Token>> {

    const route = this.admin.getURL() as string
    const target = String(route).substring(0, 5)
    const credentials = {
      port: 5002,
      type: 'user',
      token: JSON.parse(this.userService.getToken()),
      refresh_token: JSON.parse(this.userService.getRefreshToken())
    }
    if(target === 'Admin') {
      credentials.type = 'admin'
      credentials.port = 5001
    }
    const api_url = `http://localhost:${credentials.port}/api/${credentials.type}/token`
    request = request.clone({
      setHeaders: {
        authorization: `Bearer ${credentials.token}`
      }
    })
    return next.handle(request).pipe(
      catchError((err: HttpErrorResponse)=> {
        if(err.status === 403) {
          return this.http.post<HttpEvent<Token>>(api_url, {token: credentials.refresh_token}, {withCredentials: true}).pipe(
            switchMap(res => {
              return next.handle(request.clone({
                setHeaders: {
                  authorization: `Bearer ${res}`
                }
              }))
            })
          )
        }
        return throwError(() => err)
      })
    )
  }
}

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

@Injectable()
export class AuthInterceptor implements HttpInterceptor {

  constructor(private memberService: MemberService, private http: HttpClient) {}

  intercept(request: HttpRequest<Token>, next: HttpHandler): Observable<HttpEvent<Token>> {

    const token = JSON.parse(this.memberService.getToken())
    request = request.clone({
      setHeaders: {
        authorization: `Bearer ${token}`
      }
    })

    return next.handle(request).pipe(
      catchError((err: HttpErrorResponse)=> {
        if(err.status === 403) {
          const refresh_token = this.memberService.getRefreshToken()
          return this.http.post<HttpEvent<Token>>('http://localhost:5002/api/user/token', {token: JSON.parse(refresh_token)}, {withCredentials: true}).pipe(
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

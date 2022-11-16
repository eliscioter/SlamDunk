import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor
} from '@angular/common/http';
import { finalize, Observable } from 'rxjs';

import { LoadingService } from 'src/app/services/loading/loading.service';

@Injectable()
export class NetworkInterceptor implements HttpInterceptor {

  private total_requests: number = 0
  private requests_completed: number = 0

  constructor(private loader: LoadingService) {}

  intercept(request: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {

    this.loader.show()
    this.total_requests++

    return next.handle(request).pipe(
      finalize(() => {
        this.requests_completed++
        if (this.requests_completed === this.total_requests) {
          this.loader.hide();
          this.total_requests = 0; 
          this.requests_completed = 0;
        }
      })
    );
  }
}

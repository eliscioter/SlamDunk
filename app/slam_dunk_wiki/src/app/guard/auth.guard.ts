import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, RouterStateSnapshot, UrlTree, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { ToastrService } from 'ngx-toastr';

import { UserService } from '../services/user/user.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {

  constructor(private user: UserService, private router: Router, private toast: ToastrService) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {

      if(!this.user.isLoggedIn()) {
        this.toast.info('You must be logged in first')

        this.router.navigate(['/'])
        return false
      }
      
    return true;
  }
  
}

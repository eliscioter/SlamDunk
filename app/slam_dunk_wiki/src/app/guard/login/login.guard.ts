import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, RouterStateSnapshot, UrlTree, Router } from '@angular/router';
import { Observable } from 'rxjs';

import { UserService } from 'src/app/services/user/user.service';
@Injectable({
  providedIn: 'root'
})
export class LoginGuard implements CanActivate {

  constructor(private user: UserService, private router: Router){}
  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {

      if(this.user.isLoggedIn() && (this.user.getRole()?.includes('MODERATOR') || this.user.getRole()?.includes('MEMBER'))) {
        this.router.navigate(['**'])
        return false
      }
      if(this.user.isLoggedIn() && this.user.getRole()?.includes('EDITOR')) {
        this.router.navigate(['/dashboard/admin/players'])
        return false
      }
    return true;
  }
  
}

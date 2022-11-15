import { Component, Input, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog'
import { Title } from '@angular/platform-browser';
import { ToastrService } from 'ngx-toastr';

import { SignInComponent } from '../sign-in/sign-in.component'
import { MemberService } from '../../services/member/member.service';
import { AdminService } from 'src/app/services/admin/admin.service';
import { UserService } from 'src/app/services/user/user.service';
import { ActivatedRoute, Router } from '@angular/router';
@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {

  @Input() titleName!: string
  constructor(private dialog: MatDialog, 
    protected user: UserService, 
    protected member: MemberService, 
    protected admin: AdminService, 
    private router: Router,
    private toast: ToastrService) { }

  ngOnInit(): void {
  }

  openSignIn() {
    this.dialog.open(SignInComponent)
  }
  onSignOut(type: string) {
    const user = this.user.getRefreshToken() as string
    if(type === 'member') {
      this.member.signOut(user).subscribe({
        next: () => {
          this.router.navigate(['/'], { replaceUrl: true })
        }, 
        error: () => {
          this.toast.error('Something went wrong')
        }
      })
      return
    }
    if(type === 'admin') {
      this.admin.logout(user).subscribe({
        next: () => {
          this.router.navigate(['/'], { replaceUrl: true })
        }, 
        error: () => {
          this.toast.error('Something went wrong')
        }
      })
      return
    }
  }
  isAdminRoute(): boolean {
    const route =  this.admin.getURL() as string
    const target = String(route).substring(0, 5).trim()
    return target === 'Admin'
  }
}

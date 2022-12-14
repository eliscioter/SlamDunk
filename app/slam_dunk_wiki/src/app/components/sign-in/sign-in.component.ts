import { Component, OnInit } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog'
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';

import { Member } from '../../interfaces/Member'
import { MemberService } from '../../services/member/member.service';
import { AdminService } from 'src/app/services/admin/admin.service';

@Component({
  selector: 'app-sign-in',
  templateUrl: './sign-in.component.html',
  styleUrls: ['./sign-in.component.css']
})
export class SignInComponent implements OnInit {

  username!: string
  password!: string

  constructor(private dialog: MatDialogRef<SignInComponent>, 
    private member: MemberService, 
    private admin: AdminService, 
    private router: Router,
    private toast: ToastrService) {}

  ngOnInit(): void {
  }

  closeDialog() {
    this.dialog.close();
  }

  onSignIn() {
    const member: Member = {
      username: this.username,
      password: this.password
    }
    this.member.auth(member).subscribe({
      next: () => {
        this.closeDialog()
        if(this.admin.getURL() === 'Error') {
          this.router.navigate(['/'])
          this.toast.success('Sign in successful')
          return
        }
        this.toast.success('Sign in successful')
        window.location.reload()
      },
      error: () => {
        this.password = ''
        this.toast.error('Sign in failed')
      } 
    })
  }
}

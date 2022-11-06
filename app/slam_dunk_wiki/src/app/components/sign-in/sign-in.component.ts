import { Component, OnInit } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog'

import { Member } from '../../interfaces/Member'
import { MemberService } from '../../services/member/member.service';

@Component({
  selector: 'app-sign-in',
  templateUrl: './sign-in.component.html',
  styleUrls: ['./sign-in.component.css']
})
export class SignInComponent implements OnInit {

  username!: string
  password!: string

  constructor(private dialog: MatDialogRef<SignInComponent>, private member: MemberService) { }

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
        alert('Sign in successful')
        // TODO: also reload when user sign out
        window.location.reload()
      },
      error: () => {
        this.password = ''
        alert('Sign in failed')
      } 
    })
  }
}

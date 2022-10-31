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
    this.member.auth(member).subscribe(
      next => {
        alert('Sign in successful')
      },
      error => {
        alert('Sign in failed')
      } 
    )
  }
}

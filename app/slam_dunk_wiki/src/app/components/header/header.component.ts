import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog'

import { SignInComponent } from '../sign-in/sign-in.component'
import { MemberService } from '../../services/member/member.service';
@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {

  constructor(private dialog: MatDialog, protected member: MemberService) { }

  ngOnInit(): void {
  }

  openSignIn() {
    this.dialog.open(SignInComponent)
  }
  onSignOut() {
    this.member.signOut()
  }
}

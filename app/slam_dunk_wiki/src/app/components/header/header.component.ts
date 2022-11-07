import { Component, Input, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog'
import { Title } from '@angular/platform-browser';

import { SignInComponent } from '../sign-in/sign-in.component'
import { MemberService } from '../../services/member/member.service';
import { AdminService } from 'src/app/services/admin/admin.service';
import { ActivatedRoute, Router } from '@angular/router';
@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {

  @Input() titleName!: string
  constructor(private dialog: MatDialog, protected member: MemberService, private admin: AdminService, private title: Title, private readonly route: ActivatedRoute, private router: Router) { }

  ngOnInit(): void {
    console.log(this.titleName)
  }

  openSignIn() {
    this.dialog.open(SignInComponent)
  }
  onSignOut() {
    const user = this.member.getRefreshToken() as string
    this.member.signOut(user).subscribe()
  }

  
}

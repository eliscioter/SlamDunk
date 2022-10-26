import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog'
import { SignInComponent } from '../sign-in/sign-in.component';
@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {

  constructor(private dialog: MatDialog) { }

  ngOnInit(): void {
  }

  openSignIn() {
    console.log('pressed')
    this.dialog.open(SignInComponent)
  }

  reload() {
    // location.reload()
  }
}

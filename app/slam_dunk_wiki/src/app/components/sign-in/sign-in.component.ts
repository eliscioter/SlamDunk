import { Component, OnInit } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog'

@Component({
  selector: 'app-sign-in',
  templateUrl: './sign-in.component.html',
  styleUrls: ['./sign-in.component.css']
})
export class SignInComponent implements OnInit {

  constructor(private dialog: MatDialogRef<SignInComponent>) { }

  ngOnInit(): void {
  }

  closeDialog() {
    this.dialog.close();
  }
}

import { Component, OnInit } from '@angular/core';

import { AdminService } from 'src/app/services/admin/admin.service';
@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  constructor(private admin: AdminService) { }

  ngOnInit(): void {
    this.admin.isAdmin(true)
  }

}

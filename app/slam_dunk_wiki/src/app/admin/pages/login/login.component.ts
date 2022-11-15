import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';

import { AdminService } from 'src/app/services/admin/admin.service';
import { UserService } from 'src/app/services/user/user.service';
import { Admin } from 'src/app/interfaces/admin/Admin';
@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  username!: string
  password!: string
  constructor(private admin: AdminService, private router: Router, private toast: ToastrService) { }

  ngOnInit(): void {}
  onLogin(): void {
    const user: Admin = {
      username: this.username,
      password: this.password
    }
    this.admin.auth(user).subscribe({
      next: () => {
        this.router.navigate(['/dashboard/admin/players'], { replaceUrl: true })
        
        this.toast.success(`Welcome ${this.username}`)
      },
      error: () => {this.toast.error('Login failed')}
    })
  }

}

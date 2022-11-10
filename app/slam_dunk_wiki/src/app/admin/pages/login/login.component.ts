import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

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
  constructor(private admin: AdminService, private user: UserService, private router: Router) { }

  ngOnInit(): void {}
  onLogin(): void {
    const user: Admin = {
      username: this.username,
      password: this.password
    }
    this.admin.auth(user).subscribe({
      next: () => {
        this.router.navigate(['/dashboard'], { replaceUrl: true })
        
        alert('Welcome admin!')
      },
      error: () => {alert('Login failed')}
    })
  }

}

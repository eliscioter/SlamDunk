import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';

import { Member } from '../../interfaces/Member';
import { MemberService } from '../../services/member/member.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  username!: string;
  email!: string;
  password!: string;
  re_password!: string;

  constructor(private member: MemberService, private router: Router, private toast: ToastrService) { }

  ngOnInit(): void {
  }

  private matchedPassword(): boolean {
    const pass = this.password
    const re_pass = this.re_password
    if (!pass || !re_pass) return false
    return pass === re_pass ? true : false
  }

  protected onRegister(): void {
    if (!this.matchedPassword()) {
      this.toast.warning('Password did not match')
      return 
    }
    
    const form: Member = {
      email: this.email,
      username: this.username,
      password: this.password,
      role: ['MEMBER']
    }
    const user: Member = {
      username: this.username,
      password: this.password,
    }
    this.member.register(form).subscribe({
      next: () => {
        this.toast.success('Success')
        this.member.auth(user).subscribe({
          next: () => {
            this.toast.success('Logging in')
            this.router.navigate(['/'])
          }
        })
      },
      error: () => {this.toast.error('Something went wrong')}
    })
  }
}

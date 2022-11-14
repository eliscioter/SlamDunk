import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

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

  constructor(private member: MemberService, private router: Router) { }

  ngOnInit(): void {
  }

  private matchedPassword(): boolean {
    const pass = this.password
    const re_pass = this.re_password
    console.log(`${this.email} and ${pass} and ${re_pass}`)
    if (!pass || !re_pass) return false
    return pass === re_pass ? true : false
  }

  protected onRegister(): void {
    if (!this.matchedPassword()) return alert('Password did not match')
    
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
        alert('Success')
        this.member.auth(user).subscribe({
          next: () => {
            alert('Logging in')
            this.router.navigate(['/'])
          }
        })
      },
      error: e => {alert('Something went wrong')}
    })
  }

}

import { Component, OnInit } from '@angular/core';

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

  constructor(private member: MemberService) { }

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
    this.member.register(form).subscribe(
      next => {
        console.log('Registered')
        alert('Success')
      },
      error => console.log('Something went wrong')
    )
  }

}

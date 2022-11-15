import { Component, OnInit } from '@angular/core';

import { UserService } from 'src/app/services/user/user.service';
@Component({
  selector: 'app-contact',
  templateUrl: './contact.component.html',
  styleUrls: ['./contact.component.css']
})
export class ContactComponent implements OnInit {

  name!: string
  email!: string
  comment!: string
  api_url: string = "https://formsubmit.co/slamdunkwiki@gmail.com"

  constructor(private userService: UserService) { }

  ngOnInit(): void {
    if (this.userService.isLoggedIn()){
      console.log(this.userService.getUsername())
      this.name = this.userService.getUsername()
    }
    console.log(this.name)

  }

  onSubmit() {
    if(!this.userService.isLoggedIn()) return alert('Please sign in first')
  }

}

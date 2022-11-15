import { Component, OnInit } from '@angular/core';

import { UserService } from 'src/app/services/user/user.service';
@Component({
  selector: 'app-thanks',
  templateUrl: './thanks.component.html',
  styleUrls: ['./thanks.component.css']
})
export class ThanksComponent implements OnInit {
  name!: string
  constructor(private userService: UserService) { }

  ngOnInit(): void {
    this.name = this.userService.getUsername()
  }

}

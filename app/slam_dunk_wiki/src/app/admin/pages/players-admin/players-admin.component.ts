import { Component, OnInit } from '@angular/core';
import { faTrash, faEdit } from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'app-players-admin',
  templateUrl: './players-admin.component.html',
  styleUrls: ['./players-admin.component.css']
})
export class PlayersAdminComponent implements OnInit {

  faEdit = faEdit
  faTrash = faTrash;
  
  constructor() { }

  ngOnInit(): void {
  }

}

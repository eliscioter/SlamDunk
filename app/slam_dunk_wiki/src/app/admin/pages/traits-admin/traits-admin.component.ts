import { Component, OnInit } from '@angular/core';
import { faTrash, faEdit } from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'app-traits-admin',
  templateUrl: './traits-admin.component.html',
  styleUrls: ['./traits-admin.component.css']
})
export class TraitsAdminComponent implements OnInit {

  faEdit = faEdit
  faTrash = faTrash;

  constructor() { }

  ngOnInit(): void {
  }

}

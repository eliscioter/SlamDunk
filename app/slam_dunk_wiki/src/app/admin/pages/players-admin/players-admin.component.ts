import { Component, OnInit } from '@angular/core';
import { faTrash, faEdit } from '@fortawesome/free-solid-svg-icons';

import { Player } from 'src/app/interfaces/Players';
import { PlayersService } from 'src/app/services/players/players.service';
@Component({
  selector: 'app-players-admin',
  templateUrl: './players-admin.component.html',
  styleUrls: ['./players-admin.component.css']
})
export class PlayersAdminComponent implements OnInit {

  faEdit = faEdit
  faTrash = faTrash;
  players: Player[] = [];
  
  constructor(private playerService: PlayersService) { }

  ngOnInit(): void {
    this.playerService.getPlayers().subscribe({
      next: data => {
        this.players = data
      }, 
      error: e => {
        alert('Something went wrong')
      }
    })

  }

}

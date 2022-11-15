import { Component, OnInit} from '@angular/core';
import { ToastrService } from 'ngx-toastr';

import { Player } from 'src/app/interfaces/Players';
import { PlayersService } from 'src/app/services/players/players.service';

@Component({
  selector: 'app-players',
  templateUrl: './players.component.html',
  styleUrls: ['./players.component.css']
})
export class PlayersComponent implements OnInit {
  players: Player[] = [];

  constructor(private playerService: PlayersService, private toast: ToastrService) { }

  ngOnInit(): void {
    this.playerService.getPlayers().subscribe({
      next: data => {
        this.players = data
      }, 
      error: () => {
        this.toast.error('Something went wrong')
      }
    })
  }
}

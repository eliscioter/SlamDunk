import { Component, OnInit} from '@angular/core';
import { Player } from 'src/app/interfaces/Players';
import { PlayersService } from 'src/app/services/players/players.service';

@Component({
  selector: 'app-players',
  templateUrl: './players.component.html',
  styleUrls: ['./players.component.css']
})
export class PlayersComponent implements OnInit {
  players: Player[] = [];

  constructor(private playerService: PlayersService) { }

  ngOnInit(): void {
    this.playerService.getPlayers().subscribe({
      next: data => {
        this.players = data
      }, 
      error: () => {
        alert('Something went wrong')
      }
    })
  }
}

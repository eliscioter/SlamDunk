import { Component, OnInit} from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import * as io from 'socket.io-client'

import { Player } from 'src/app/interfaces/Players';
import { PlayersService } from 'src/app/services/players/players.service';

@Component({
  selector: 'app-players',
  templateUrl: './players.component.html',
  styleUrls: ['./players.component.css']
})
export class PlayersComponent implements OnInit {
  players: Player[] = [];
  private socket: any


  constructor(private playerService: PlayersService, private toast: ToastrService) { }

  ngOnInit(): void {
    // this.socket = io.io(`http://localhost:5000`)
     this.socket = io.io(`https://slamdunk.onrender.com`)
    this.playerService.getPlayers().subscribe({
      next: data => {
        this.socket.on('receive-players', (players: Player, id: string) => {
          this.players.push({...players, _id: id})
        })
        this.socket.on('receive-new-players', (players: Player[]) => {
          this.players.splice(0, this.players.length, ...players)
        })
        this.socket.on('receive-updated-players', (players: Player) => {
          const updatedPlayers = this.players.map(item => {
            if(item._id === players._id) {
              return players
            }
            return item
          })
          this.players.splice(0, this.players.length, ...updatedPlayers)
          return
        })
        this.players = data
      }, 
      error: () => {
        this.toast.error('Something went wrong')
      }
    })
  }
}

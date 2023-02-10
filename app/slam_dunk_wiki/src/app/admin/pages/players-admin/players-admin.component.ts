import { Component, OnInit } from '@angular/core';
import { faTrash, faEdit } from '@fortawesome/free-solid-svg-icons';
import { ToastrService } from 'ngx-toastr';
import * as io from 'socket.io-client'

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
  private socket: any

  
  constructor(private playerService: PlayersService, private toast: ToastrService) { }

  ngOnInit(): void {
    this.displayPlayers()
  }

  displayPlayers() {
    // this.socket = io.io(`http://localhost:5000`)
    this.socket = io.io(`https://slamdunk.onrender.com`)
    this.playerService.getPlayers().subscribe({
      next: playerData => {

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
        this.players = playerData
      }, 
      error: () => {
        this.toast.error('Something went wrong')
      }
    })
  }

  onDelete(item: Player) {
    // this.socket = io.io(`http://localhost:5000`)
    this.socket = io.io(`https://slamdunk.onrender.com`)
    this.playerService.deletePlayer((item._id) as string).subscribe({
      next: () => {
        this.players = this.players.filter(player => player._id !== item._id)
        this.socket.emit('player', this.players, item._id, true, false)
        this.toast.success(`${item.player.profile.player_name.first_name} ${item.player.profile.player_name.last_name} deleted successfully`)
      }, error: () => this.toast.error('Something went wrong')
    })
  }

}

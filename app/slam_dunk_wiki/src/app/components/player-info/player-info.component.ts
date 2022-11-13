import { Component,Input, OnInit } from '@angular/core';
import { PlayersService } from 'src/app/services/players/players.service';
import { Player } from 'src/app/interfaces/Players';
@Component({
  selector: 'app-player-info',
  templateUrl: './player-info.component.html',
  styleUrls: ['./player-info.component.css']
})
export class PlayerInfoComponent implements OnInit {
  @Input() item!: Player 
  
  constructor() {
    
   }

  ngOnInit(): void {
    console.log(this.item)
  }

}

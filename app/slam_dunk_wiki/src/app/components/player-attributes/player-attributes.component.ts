import { Component, OnInit, Input } from '@angular/core';
import { Player } from 'src/app/interfaces/Players';

@Component({
  selector: 'app-player-attributes',
  templateUrl: './player-attributes.component.html',
  styleUrls: ['./player-attributes.component.css']
})
export class PlayerAttributesComponent implements OnInit {

  @Input() item: Player[] = []
  value!: number
  constructor() { }

  ngOnInit(): void {
    // this.value = Number(this.item[0].player.attributes.offense.close) / 2
    console.log(this.item)
  }

}

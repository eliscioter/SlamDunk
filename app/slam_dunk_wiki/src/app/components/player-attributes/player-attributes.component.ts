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
  }

}

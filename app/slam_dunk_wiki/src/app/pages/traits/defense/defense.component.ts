import { Component, OnInit } from '@angular/core';
import * as io from 'socket.io-client'

import { Trait } from 'src/app/interfaces/Traits';
import { TraitsService } from 'src/app/services/traits/traits.service';

@Component({
  selector: 'app-defense',
  templateUrl: './defense.component.html',
  styleUrls: ['./defense.component.css']
})
export class DefenseComponent implements OnInit {

  traits: Trait[] = []
  private socket: any
  private tag: string = 'defense'

  constructor(private traitsService: TraitsService) { }

  ngOnInit(): void {
    // this.socket = io.io(`http://localhost:5000`)
    this.socket = io.io(`https://slamdunk.onrender.com`)
    this.traitsService.getTraits().subscribe({
      next: trait => {
        this.socket.on('receive-traits', (trait: Trait, id: string) => {
          if(trait.tag !== this.tag) return
          this.traits.push({...trait, _id: id})
        })
        this.socket.on('receive-new-traits', (trait: Trait[]) => {
          this.traits.splice(0, this.traits.length, ...trait.filter(item => item.tag === this.tag))
        })
        this.socket.on('receive-updated-traits', (trait: Trait) => {
          const updatedTraits = this.traits.map(item => {
            if (item._id === trait._id) {
              return trait
            }
            return item
          })
          this.traits = updatedTraits.filter(item => item.tag === this.tag)
          return
        })
        this.traits = trait.filter(item => item.tag === this.tag)
      }
    })
  }

}

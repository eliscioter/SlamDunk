import { Component, OnInit } from '@angular/core';
import { Trait } from 'src/app/interfaces/Traits';
import { TraitsService } from 'src/app/services/traits/traits.service';

@Component({
  selector: 'app-traits',
  templateUrl: './traits.component.html',
  styleUrls: ['./traits.component.css']
})
export class TraitsComponent implements OnInit {

  traits: Trait[] = []
  constructor(private traitsService: TraitsService) { }

  ngOnInit(): void {
    this.traitsService.getTraits().subscribe({
      next: trait => {
        this.traits = trait.filter(item => item.tag === 'offense')
      }
    })
  }

}

import { Component, OnInit } from '@angular/core';
import { faTrash, faEdit } from '@fortawesome/free-solid-svg-icons';

import { Trait } from 'src/app/interfaces/Traits';
import { TraitsService } from 'src/app/services/traits/traits.service';
@Component({
  selector: 'app-traits-admin',
  templateUrl: './traits-admin.component.html',
  styleUrls: ['./traits-admin.component.css']
})
export class TraitsAdminComponent implements OnInit {

  faEdit = faEdit
  faTrash = faTrash;
  traits: Trait[] = []
  id!: string;
  title!: string
  description!: string
  imgURL!: string
  tag!: string
  buttonName!: string

  constructor(private traitsService: TraitsService) { }

  ngOnInit(): void {
    this.traitsService.getTraits().subscribe({
      next: trait => {
        this.traits = trait
      }
    })
    
  }

  createButton(): string {
    return this.buttonName = 'Create'
  }

  isCreateType(): boolean {
    if(this.buttonName === 'Create') {
      this.create_trait()
      return true 
    }
    return false
  }

  create_trait() {
    const trait: Trait = {
      name: this.title,
      description: this.description,
      image_url: this.imgURL,
      tag: this.tag
    }
    this.traitsService.createTrait(trait).subscribe({
      next: () => {
        window.location.reload()
      }, error: () => alert('Something went wrong')
    })
  }
  
  onUpdate(item: Trait) {
    this.buttonName = 'Save'
    this.id = (item._id) as string
    this.traitsService.getTrait(this.id).subscribe({
      next: res => {
        this.title = res.name
        this.description = res.description
        this.imgURL = res.image_url
        this.tag = res.tag
        
      }, error: () => alert('Something went wrong')
    })
  }

  update_trait() {
    const updatedTrait: Trait = {
      _id: this.id,
      name: this.title,
      description: this.description,
      image_url: this.imgURL,
      tag: this.tag
    }
    this.traitsService.updateTrait(updatedTrait).subscribe({
      next: () => {
        alert(`${updatedTrait.name} successfully updated`)
        window.location.reload()
      }, error: () => alert('Something went wrong')
    })
  }

  delete_trait(item: Trait) {
    this.traitsService.deleteTrait((item._id) as string).subscribe({
      next: () => {
        this.traits = this.traits.filter(trait => trait._id !== trait._id)
        window.location.reload()
      }, error: () => alert('Something went wrong')
    })
  }

}

import { Component, OnInit } from '@angular/core';
import { faTrash, faEdit } from '@fortawesome/free-solid-svg-icons';
import { ToastrService } from 'ngx-toastr';
import * as io from 'socket.io-client'

import { Trait } from 'src/app/interfaces/Traits';
import { TraitsService } from 'src/app/services/traits/traits.service';

declare var $: any;

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
  private socket: any

  constructor(private traitsService: TraitsService, private toast: ToastrService) { }

  ngOnInit(): void {
    this.displayTraits()
  }

  displayTraits() {
    // this.socket = io.io(`http://localhost:5000`)
    this.socket = io.io(`https://slamdunk.onrender.com`)
    this.traitsService.getTraits().subscribe({
      next: traitData => {
        this.socket.on('receive-traits', (trait: Trait, id: string) => {
          this.traits.push({...trait, _id: id})
        })
        this.socket.on('receive-new-traits', (trait: Trait[]) => {
          this.traits.splice(0, this.traits.length, ...trait)
        })
        this.socket.on('receive-updated-traits', (trait: Trait) => {
          const updatedTraits = this.traits.map(item => {
            if (item._id === trait._id) {
              return trait
            }
            return item
          })
          this.traits = updatedTraits
          return
        })
        this.traits = traitData
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
    // this.socket = io.io(`http://localhost:5000`)
    this.socket = io.io(`https://slamdunk.onrender.com`)
    const trait: Trait = {
      name: this.title,
      description: this.description,
      image_url: this.imgURL,
      tag: this.tag
    }
    this.traitsService.createTrait(trait).subscribe({
      next: traitData => {       

        this.socket.emit('trait', trait, traitData._id, false, false)
        $('#create_trait').modal('hide')

        this.toast.success(`Created ${this.title} successfully`)
      }, error: () => this.toast.error('Something went wrong')
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
        
      }, error: () => this.toast.error('Something went wrong')
    })
  }

  update_trait() {
    // this.socket = io.io(`http://localhost:5000`)
    this.socket = io.io(`https://slamdunk.onrender.com`)
    const updatedTrait: Trait = {
      _id: this.id,
      name: this.title,
      description: this.description,
      image_url: this.imgURL,
      tag: this.tag
    }
    this.traitsService.updateTrait(updatedTrait).subscribe({
      next: () => {
        this.socket.emit('trait', updatedTrait, updatedTrait._id, false, true)
        $('#create_trait').modal('hide')

        this.toast.success(`${updatedTrait.name} successfully updated`)
      }, error: () => this.toast.error('Something went wrong')
    })
  }

  delete_trait(item: Trait) {
    // this.socket = io.io(`http://localhost:5000`)
    this.socket = io.io(`https://slamdunk.onrender.com`)
    this.traitsService.deleteTrait((item._id) as string).subscribe({
      next: () => {
        this.traits = this.traits.filter(trait => trait._id !== item._id)
        this.socket.emit('trait', this.traits, item._id, true, false)
      }, error: () => alert('Something went wrong')
    })
  }

}

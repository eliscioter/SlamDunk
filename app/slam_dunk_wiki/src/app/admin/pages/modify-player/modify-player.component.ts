import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

import { Player, Talent } from 'src/app/interfaces/Players';
import { PlayersService } from 'src/app/services/players/players.service';

@Component({
  selector: 'app-modify-player',
  templateUrl: './modify-player.component.html',
  styleUrls: ['./modify-player.component.css']
})
export class ModifyPlayerComponent implements OnInit {

  id!: string;
  firstName!: string;
  lastName!: string;
  abbr!: string;
  fullVersion!: string
  imgURL!: string
  school!: string
  height!: number
  weight!: number
  description!: string
  control!: number
  res!: number
  run!: number
  strength!: number
  jump!: number
  dribble!: number
  close!: number
  three_pointer!: number
  middle!: number
  dunk!: number
  layup!: number
  reb!: number
  blk!: number
  jam!: number
  stl!: number
  tag!: string
  talent: Talent[] = []

  constructor(private playerService: PlayersService, private route: ActivatedRoute, private router: Router) { 
    this.id = this.route.snapshot.params['_id']
  }

  ngOnInit(): void {
    this.playerService.getPlayer(this.id).subscribe({
      next: item => {
        this.firstName = item.player.profile.player_name.first_name
        this.lastName = item.player.profile.player_name.last_name
        this.abbr = item.player.profile.position.abbr
        this.fullVersion = item.player.profile.position.full_version
        this.imgURL = item.player.profile.image_url
        this.school = item.player.profile.school
        this.height = item.player.profile.height
        this.weight = item.player.profile.weight
        this.description = item.player.profile.description
        this.control = item.player.attributes.general.control
        this.res = item.player.attributes.general.res
        this.run = item.player.attributes.general.run
        this.strength = item.player.attributes.general.strength
        this.jump = item.player.attributes.general.jump
        this.dribble = item.player.attributes.general.dribble
        this.close = item.player.attributes.offense.close
        this.three_pointer = item.player.attributes.offense.three_pointer
        this.middle = item.player.attributes.offense.middle
        this.dunk = item.player.attributes.offense.dunk
        this.layup = item.player.attributes.offense.layup
        this.reb = item.player.attributes.defense.reb
        this.blk = item.player.attributes.defense.blk
        this.jam = item.player.attributes.defense.jam
        this.stl = item.player.attributes.defense.stl
        this.tag = item.tag
        const talents = Object.values(item.player.talents)
        for (let i = 0; i < talents.length; i++) {
          this.talent.push(talents[i])
        }
      }
    }) 
  }

 
  onUpdate() {
    const player: Player = {
      _id: this.id,
      player: {
          profile: { 
              player_name: {
                  first_name: this.firstName,
                  last_name: this.lastName
              },
              image_url: this.imgURL,
              position: {
                  abbr: this.abbr,
                  full_version: this.fullVersion
              },
              school: this.school,
              height: this.height,
              weight: this.weight,
              description: this.description,
          },
          attributes: {
              general: {
                  control: this.control,
                  strength: this.strength,
                  res: this.res,
                  jump: this.jump,
                  run: this.run,
                  dribble: this.dribble,
              },
              offense: {
                  close: this.close,
                  middle: this.middle,
                  three_pointer: this.three_pointer,
                  dunk: this.dunk,
                  layup: this.layup
              },
              defense: {
                  reb: this.reb,
                  blk: this.blk,
                  jam: this.jam,
                  stl: this.stl
              }
          },
          talents: {
              talent1: {
                  name: this.talent[0].name,
                  description: this.talent[0].description,
                  talent_image_url: this.talent[0].talent_image_url,
              },
              talent2: {
                name: this.talent[1].name,
                description: this.talent[1].description,
                talent_image_url: this.talent[1].talent_image_url,
              },
              talent3: {
                name: this.talent[2].name,
                description: this.talent[2].description,
                talent_image_url: this.talent[2].talent_image_url,
              },
              talent4: {
                name: this.talent[3].name,
                description: this.talent[3].description,
                talent_image_url: this.talent[3].talent_image_url,
              },
              talent5: {
                name: this.talent[4].name,
                description: this.talent[4].description,
                talent_image_url: this.talent[4].talent_image_url,
              },
              talent6: {
                name: this.talent[5].name,
                description: this.talent[5].description,
                talent_image_url: this.talent[5].talent_image_url,
              },
          }
          
      },
      tag: this.tag
    }
    this.playerService.updatePlayer(player).subscribe({
      next: () => {
        alert(`${this.firstName} ${this.lastName} successfully updated`)
        this.router.navigate(['/dashboard/admin/players'])
      }, error: () => alert('Something went wrong')
    })
  }


}

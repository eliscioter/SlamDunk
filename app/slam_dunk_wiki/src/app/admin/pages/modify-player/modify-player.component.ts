import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import * as io from 'socket.io-client'

import { Player } from 'src/app/interfaces/Players';
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
  tl1_name!: string
  tl1_desc!: string
  tl1_img_url!: string
  tl2_name!: string
  tl2_desc!: string
  tl2_img_url!: string
  tl3_name!: string
  tl3_desc!: string
  tl3_img_url!: string
  tl4_name!: string
  tl4_desc!: string
  tl4_img_url!: string
  tl5_name!: string
  tl5_desc!: string
  tl5_img_url!: string
  tl6_name!: string
  tl6_desc!: string
  tl6_img_url!: string
  private socket: any

  constructor(private playerService: PlayersService, private route: ActivatedRoute, private router: Router, private toast: ToastrService) { 
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
        this.tl1_name = item.player.talents.talent1.name
        this.tl1_desc = item.player.talents.talent1.description
        this.tl1_img_url = item.player.talents.talent1.talent_image_url
        this.tl2_name = item.player.talents.talent2.name
        this.tl2_desc = item.player.talents.talent2.description
        this.tl2_img_url = item.player.talents.talent2.talent_image_url
        this.tl3_name = item.player.talents.talent3.name
        this.tl3_desc = item.player.talents.talent3.description
        this.tl3_img_url = item.player.talents.talent3.talent_image_url
        this.tl4_name = item.player.talents.talent4.name
        this.tl4_desc = item.player.talents.talent4.description
        this.tl4_img_url = item.player.talents.talent4.talent_image_url
        this.tl5_name = item.player.talents.talent5.name
        this.tl5_desc = item.player.talents.talent5.description
        this.tl5_img_url = item.player.talents.talent5.talent_image_url
        this.tl6_name = item.player.talents.talent6.name
        this.tl6_desc = item.player.talents.talent6.description
        this.tl6_img_url = item.player.talents.talent6.talent_image_url
      }
    }) 
  }

 
  onUpdate() {
    // this.socket = io.io(`http://localhost:5000`)
    this.socket = io.io(`https://slamdunk.onrender.com`)
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
                  name: this.tl1_name,
                  description: this.tl1_desc,
                  talent_image_url: this.tl1_img_url,
              },
              talent2: {
                name: this.tl2_name,
                description: this.tl2_desc,
                talent_image_url: this.tl2_img_url,
              },
              talent3: {
                name: this.tl3_name,
                description: this.tl3_desc,
                talent_image_url: this.tl3_img_url,
              },
              talent4: {
                name: this.tl4_name,
                description: this.tl4_desc,
                talent_image_url: this.tl4_img_url,
              },
              talent5: {
                name: this.tl5_name,
                description: this.tl5_desc,
                talent_image_url: this.tl5_img_url,
              },
              talent6: {
                name: this.tl6_name,
                description: this.tl6_desc,
                talent_image_url: this.tl6_img_url,
              },
          }
          
      },
      tag: this.tag
    }
    this.playerService.updatePlayer(player).subscribe({
      next: () => {
        this.socket.emit('player', player, player._id, false, true)
        this.toast.success(`${this.firstName} ${this.lastName} successfully updated`)
        this.router.navigate(['/dashboard/admin/players'])
      }, error: () => this.toast.error('Something went wrong')
    })
  }


}

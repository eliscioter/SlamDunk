import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import { Player } from 'src/app/interfaces/Players';
import { PlayersService } from 'src/app/services/players/players.service';

@Component({
  selector: 'app-create-player',
  templateUrl: './create-player.component.html',
  styleUrls: ['./create-player.component.css']
})
export class CreatePlayerComponent implements OnInit {

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
  tag!: string

  constructor(private player: PlayersService, private router: Router) { }

  ngOnInit(): void {
  }

  onCreatePlayer(): void {
    const createPlayer: Player = {
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
                layup: this.layup,
            },
            defense: {
                reb: this.reb,
                blk: this.blk,
                jam: this.jam,
                stl: this.stl,
            }
        },
        talents: {
            talent1: {
                name: this.tl1_name,
                description: this.tl1_desc,
                talent_image_url: this.tl1_img_url
            },
            talent2: {
                name: this.tl2_name,
                description: this.tl2_desc,
                talent_image_url: this.tl2_img_url
            },
            talent3: {
                name: this.tl3_name,
                description: this.tl3_desc,
                talent_image_url: this.tl3_img_url
            },
            talent4: { 
                name: this.tl4_name,
                description: this.tl4_desc,
                talent_image_url: this.tl4_img_url
            },
            talent5: {
                name: this.tl5_name,
                description: this.tl5_desc,
                talent_image_url: this.tl5_img_url
            },
            talent6: {
                name: this.tl6_name,
                description: this.tl6_desc,
                talent_image_url: this.tl6_img_url
            },
        }
      },
      tag: this.tag
    }
    this.player.createPlayer(createPlayer).subscribe({
      next: data => {
        alert('Player created successfully')
        this.router.navigate(['/dashboard/admin/players'])
      }, 
      error: e => {
        alert('Something went wrong')
      }
    })
  }
}

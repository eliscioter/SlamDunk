import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { PlayersService } from 'src/app/services/players/players.service';
import { Player } from 'src/app/interfaces/Players';
@Component({
  selector: 'app-player-dasboard',
  templateUrl: './player-dasboard.component.html',
  styleUrls: ['./player-dasboard.component.css']
})
export class PlayerDasboardComponent implements OnInit {

  data: Player[] = []
  id!:string
  bg!:string
  constructor(private route: ActivatedRoute,private playerservice:PlayersService) { 
    this.id=this.route.snapshot.params['id']
  }

  ngOnInit(): void {
    this.playerservice.getPlayer(this.id).subscribe({
      next: player => {
        const obj: Player = {
          _id: player._id,
          player: {
              profile: { 
                  player_name: {
                      first_name: player.player.profile.player_name.first_name,
                      last_name: player.player.profile.player_name.last_name,
                  },
                  image_url: player.player.profile.image_url,
                  position: {
                      abbr: player.player.profile.position.abbr,
                      full_version: player.player.profile.position.full_version
                  },
                  school: player.player.profile.school,
                  height: player.player.profile.height,
                  weight: player.player.profile.weight,
                  description: player.player.profile.description,
              },
          attributes: {
              general: {
                  control: player.player.attributes.general.control,
                  strength: player.player.attributes.general.strength,
                  res: player.player.attributes.general.res,
                  jump: player.player.attributes.general.jump,
                  run: player.player.attributes.general.run,
                  dribble: player.player.attributes.general.dribble,
              },
              offense: {
                  close: player.player.attributes.offense.close,
                  middle: player.player.attributes.offense.middle,
                  three_pointer: player.player.attributes.offense.three_pointer,
                  dunk: player.player.attributes.offense.dunk,
                  layup: player.player.attributes.offense.layup
              },
              defense: {
                  reb: player.player.attributes.defense.reb,
                  blk: player.player.attributes.defense.blk,
                  jam: player.player.attributes.defense.jam,
                  stl: player.player.attributes.defense.stl
              }
          },
          talents: {
              talent1: {
                  name: player.player.talents.talent1.name,
                  description: player.player.talents.talent1.description,
                  talent_image_url: player.player.talents.talent1.talent_image_url,
              },
              talent2: {
                name: player.player.talents.talent2.name,
                description: player.player.talents.talent2.description,
                talent_image_url: player.player.talents.talent2.talent_image_url,
              },
              talent3: {
                name: player.player.talents.talent3.name,
                description: player.player.talents.talent3.description,
                talent_image_url: player.player.talents.talent3.talent_image_url,
              },
              talent4: {
                name: player.player.talents.talent4.name,
                description: player.player.talents.talent4.description,
                talent_image_url: player.player.talents.talent4.talent_image_url,
              },
              talent5: {
                name: player.player.talents.talent5.name,
                description: player.player.talents.talent5.description,
                talent_image_url: player.player.talents.talent5.talent_image_url,
              },
              talent6: {
                name: player.player.talents.talent6.name,
                description: player.player.talents.talent6.description,
                talent_image_url: player.player.talents.talent6.talent_image_url,
              },
          }
          
        },
          tag: player.tag
        }
        this.data.push(obj)
        console.log(this.data)

        // if (obj.player.profile.player_name.first_name === "ben"){
        //   this.bg = "../../../assets/new-akagi.png"
        // }
        // if (obj.player.profile.player_name.first_name === "hanagata"){
        //   this.bg = "../../../assets/new-ryota.png"
        // }
        // if (obj.player.profile.player_name.first_name === "hasegawa"){
        //   this.bg = "../../../assets/new-sakuragi.png"
        // }
        
      },error:e => console.log(e)
    })

    
  }

}

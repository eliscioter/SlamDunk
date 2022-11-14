import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

import { Player, Talent } from 'src/app/interfaces/Players';
import { Observable } from 'rxjs';
@Injectable({
  providedIn: 'root'
})
export class PlayersService {

  private api_url = 'https://slamdunk.onrender.com/api/data'

  constructor(private http: HttpClient) { }

  getPlayers(): Observable<Player[]> {
    return this.http.get<Player[]>(`${this.api_url}/players`)
  }

  getPlayer(id: string): Observable<Player> {
    return this.http.get<Player>(`${this.api_url}/player/${id}`)
  }

  createPlayer(player: Player): Observable<Player> {
    return this.http.post<Player>(`${this.api_url}/store/player`, player)
  }

  updatePlayer(player: Player): Observable<Player> {
    return this.http.put<Player>(`${this.api_url}/player/modify/${player._id}`, player)
  }

  deletePlayer(player: string): Observable<Player> {
    return this.http.delete<Player>(`${this.api_url}/player/delete/${player}`)
  }
}

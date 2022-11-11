import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

import { Player, Talent } from 'src/app/interfaces/Players';
import { Observable } from 'rxjs';
@Injectable({
  providedIn: 'root'
})
export class PlayersService {

  private api_url = 'https://slamdunk.onrender.com/api/data'

  private dummy_api_url = 'http://localhost:5000/api/data'

  constructor(private http: HttpClient) { }

  getPlayers(): Observable<Player[]> {
    return this.http.get<Player[]>(`${this.dummy_api_url}/players`)
  }

  getPlayer(id: string): Observable<Player> {
    return this.http.get<Player>(`${this.dummy_api_url}/player/${id}`)
  }

  createPlayer(player: Player): Observable<Player> {
    return this.http.post<Player>(`${this.dummy_api_url}/store/player`, player)
  }
}

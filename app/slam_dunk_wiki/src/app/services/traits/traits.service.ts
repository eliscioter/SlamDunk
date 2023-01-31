import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

import { Trait } from 'src/app/interfaces/Traits';
@Injectable({
  providedIn: 'root'
})
export class TraitsService {

  private api_url = 'https://slamdunk.onrender.com/api/data'
  // private api_url = 'http://localhost:5000/api/data'

  constructor(private http: HttpClient) { }

  getTraits(): Observable<Trait[]> {
    return this.http.get<Trait[]>(`${this.api_url}/traits`)
  }

  getTrait(id: string): Observable<Trait> {
    return this.http.get<Trait>(`${this.api_url}/trait/${id}`)
  }

  createTrait(item: Trait): Observable<Trait> {
    return this.http.post<Trait>(`${this.api_url}/store/trait`, item)
  }

  updateTrait(item: Trait): Observable<Trait> {
    return this.http.put<Trait>(`${this.api_url}/trait/modify/${item._id}`, item)
  }

  deleteTrait(item: string): Observable<Trait> {
    return this.http.delete<Trait>(`${this.api_url}/trait/delete/${item}`)
  }

  
}

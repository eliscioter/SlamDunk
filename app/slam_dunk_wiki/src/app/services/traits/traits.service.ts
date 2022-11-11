import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class TraitsService {

  private api_url = 'https://slamdunk.onrender.com/api/data/traits'

  constructor(private http: HttpClient) { }

  
}

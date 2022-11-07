import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class AdminService {

  constructor() { }

  isAdmin(flag: boolean): boolean {
    return flag
  }

  
}

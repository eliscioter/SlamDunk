import { Component } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { Router, NavigationEnd, ActivatedRoute } from '@angular/router';
import { filter } from 'rxjs/operators';

import { LoadingService } from './services/loading/loading.service';
import { AdminService } from './services/admin/admin.service';
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {

  protected nameT!: string;
  protected loading$ = this.loader.loading$

  constructor(private titleService: Title, 
    private router: Router, 
    private readonly route: 
    ActivatedRoute, 
    private admin: AdminService, 
    private loader: LoadingService) {}
  
  ngOnInit() {
    
    type Title = {
      title: string
    }
    this.router.events.pipe(filter(event => event instanceof NavigationEnd)).subscribe(() => {
      const rt = this.getChild(this.route)
      rt.data.subscribe((data: Title) => {
        this.titleService.setTitle(data.title)
        this.admin.storeURL(data.title)
      })
    })
  }

  getChild(activatedRoute: ActivatedRoute): any {
    if (activatedRoute.firstChild) return this.getChild(activatedRoute.firstChild)
    return activatedRoute;
  }
}

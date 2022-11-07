import { Component } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { Router, NavigationEnd, ActivatedRoute, RoutesRecognized } from '@angular/router';
import { filter, map } from 'rxjs/operators';


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {

  // TODO: remove sign in when on admin login
  nameT!: string;

  constructor(private titleService: Title, private router: Router, private readonly route: ActivatedRoute) {}
  
  ngOnInit() {
    
    type Title = {
      title: string
    }
    this.router.events.pipe(filter(event => event instanceof NavigationEnd)).subscribe(() => {
      const rt = this.getChild(this.route)
      rt.data.subscribe((data: Title) => {
        this.titleService.setTitle(data.title)
        this.setTitle(data.title)
      })
    })
  }

  setTitle(value: string): void {
    console.log(value)
    this.nameT = value
  }

  getTitle(): string {
    return this.nameT
  }
  getChild(activatedRoute: ActivatedRoute): any {
    if (activatedRoute.firstChild) return this.getChild(activatedRoute.firstChild)
    return activatedRoute;
  }
}

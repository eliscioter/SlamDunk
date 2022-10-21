import { Component, OnInit } from '@angular/core';
import { faFacebook, faInstagram, faTwitter, faYoutube, faReddit } from '@fortawesome/free-brands-svg-icons'

@Component({
  selector: 'app-footer',
  templateUrl: './footer.component.html',
  styleUrls: ['./footer.component.css']
})
export class FooterComponent implements OnInit {

  faFacebook = faFacebook
  faInstagram = faInstagram
  faTwitter = faTwitter
  faYoutube = faYoutube
  faReddit = faReddit
  date = new Date().getFullYear()

  constructor() { }

  ngOnInit(): void {
  }

}

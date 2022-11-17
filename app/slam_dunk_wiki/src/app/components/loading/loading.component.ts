import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-loading',
  templateUrl: './loading.component.html',
  styleUrls: ['./loading.component.css']
})
export class LoadingComponent implements OnInit {

  quote!: string
  author!: string

  constructor() { }

  ngOnInit(): void {
    const quotes = this.getQuotes().map(item => {
      return [item.quote, item.author]
    })

    this.quote = quotes[Math.floor(Math.random() * quotes.length)][0]
    this.author = quotes[Math.floor(Math.random() * quotes.length)][1]
  }

  getQuotes(): {quote: string, author: string}[] {
    return [
      { 
        quote: 'It is not too late to change ourselves and have a meaningful life.',
        author: 'Hanamichi Sakuragi'
      },
      { 
        quote: 'Basics are important. Isn’t that right, Gori?',
        author: 'Hanamichi Sakuragi'
      },
      { 
        quote: 'You guys common knowldege about basketball, does not work against me… Because I am just an amateur.',
        author: 'Hanamichi Sakuragi'
      },
      { 
        quote: 'Even geniuses make mistakes.',
        author: 'Haruko'
      },
      { 
        quote: 'No one can ever know how to do everything without learning it first.',
        author: 'Haruko'
      },
      { 
        quote: "Keep practicing, never let somebody tell you you're too small or too slow.",
        author: 'Ryota Miyagi'
      },
      {
        quote: "If you give up, that's the end of the game.",
        author: 'Coach Anzai'
      },
      { 
        quote: 'For an inadequate person… The path to reach a higher level… He must admit his poorness which is the first step.',
        author: 'Coach Anzai'
      },
    ]
  }

}

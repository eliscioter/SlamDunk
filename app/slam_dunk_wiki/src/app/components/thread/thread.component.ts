import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { ForumService } from '../../services/forum/forum.service';
import { Body } from '../../interfaces/ForumBody';
@Component({
  selector: 'app-thread',
  templateUrl: './thread.component.html',
  styleUrls: ['./thread.component.css']
})
export class ThreadComponent implements OnInit {

    id!: string;
    data: Body[] = []
    constructor(private route: ActivatedRoute, private forumService: ForumService) { 
    this.id = this.route?.snapshot.params['id']
  }

  ngOnInit(): void {
    this.displayComments()
  }


  displayComments() {
    this.forumService.getForum(this.id).subscribe( data => {
      this.data = data.body
    })
  }

}

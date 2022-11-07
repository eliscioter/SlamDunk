import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { ForumService } from '../../services/forum/forum.service';
import { MemberService } from 'src/app/services/member/member.service';
import { Body } from '../../interfaces/ForumBody';
import { Comment } from 'src/app/interfaces/ForumComment';
import { Forum } from 'src/app/interfaces/Forum';
@Component({
  selector: 'app-forum-thread',
  templateUrl: './forum-thread.component.html',
  styleUrls: ['./forum-thread.component.css'],
})
export class ForumThreadComponent implements OnInit {

  id!: string;
  title!: string;
  author!: string;
  comment!: string;
  data: Body[] = []
  constructor(private forumService: ForumService, private memberService: MemberService, private route: ActivatedRoute) {
    this.id = this.route.snapshot.params['id']
  }

  ngOnInit(): void {
    if (!this.memberService.isLoggedIn()) return alert('You must be logged in')
    this.forumService.getForum(this.id).subscribe( data => {
      this.data = data.body
      this.title = data.title
      this.author = this.memberService.getUsername()
      if(window.localStorage) {
        if( !localStorage.getItem('firstLoad') ) {
          localStorage['firstLoad'] = true;
          window.location.reload();
        }  
        else 
          localStorage.removeItem('firstLoad');
      }
      
    })
    
  }

  onReply() {
    const comment: Comment = {
      body: {
        author: this.author,
        content: this.comment
      }
    }
    this.forumService.commentForum(comment, this.id).subscribe(
      next => {
        console.log('success')
        this.comment = ''
        window.location.reload()
      }, error => {
        error.statusText === 'Unauthorized' ? alert('You need to sign in first') : error
      }
    )
  }
}

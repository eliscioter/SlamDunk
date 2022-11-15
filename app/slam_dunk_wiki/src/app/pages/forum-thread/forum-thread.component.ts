import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ToastrService } from 'ngx-toastr';

import { ForumService } from '../../services/forum/forum.service';
import { MemberService } from 'src/app/services/member/member.service';
import { Body } from '../../interfaces/ForumBody';
import { Comment } from 'src/app/interfaces/ForumComment';
import { UserService } from '../../services/user/user.service'
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
  constructor(private forumService: ForumService, 
    private userService: UserService, 
    private route: ActivatedRoute,
    private toast: ToastrService) {
    this.id = this.route.snapshot.params['id']
  }

  ngOnInit(): void {
    if (!this.userService.isLoggedIn()){
      this.toast.info('You must be logged in')
      return 
    }
    this.forumService.getForum(this.id).subscribe( data => {
      this.data = data.body
      this.title = data.title
      this.author = this.userService.getUsername()
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
    this.forumService.commentForum(comment, this.id).subscribe({
      next: () => {
        this.comment = ''
        window.location.reload()
      }, error: (error) => {
        error.statusText === 'Unauthorized' ? this.toast.info('You need to sign in first') : error
      }
    })
  }
}

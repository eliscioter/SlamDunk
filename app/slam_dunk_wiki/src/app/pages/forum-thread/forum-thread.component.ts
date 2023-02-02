import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import * as io from 'socket.io-client'

import { ForumService } from '../../services/forum/forum.service';
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
  private socket: any;

  constructor(private forumService: ForumService, 
    private userService: UserService, 
    private route: ActivatedRoute,
    private toast: ToastrService) {
    this.id = this.route.snapshot.params['id']
  }

  ngOnInit(): void {
    this.displayThread()
  }

  displayThread() {
    if (!this.userService.isLoggedIn()){
      this.toast.info('You must be logged in')
      return 
    }
    
      
    // this.socket = io.io(`http://localhost:5003`)
    this.socket = io.io(`https://slamdunkforum.onrender.com`)

    this.socket.emit('join-thread', this.id)
    this.forumService.getForum(this.id).subscribe({
      next: comment => 
      {
        if(window.localStorage) {
          if( !localStorage.getItem('firstLoad') ) {
            localStorage['firstLoad'] = true;
            window.location.reload();
          }  
          else 
            localStorage.removeItem('firstLoad');
        }
        this.socket.on('comment', (newComment: Comment) => {
          console.log(comment.body[(comment.body.length - 1)])
          const sendComment: Body = {
            author: newComment.body.author,
            content: newComment.body.content,
            title: '',
            primary_author: '',
            body: []
          };
          this.data.push(sendComment)
          
        })
        this.socket.on('new-comment', (newComment: Body[]) => {
          this.data.splice(0, this.data.length, ...newComment)
          
        })
        this.data = comment.body
        this.title = comment.title
        this.author = this.userService.getUsername()
        
      }, error: () => this.toast.error('Something went wrong')
      
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
        // this.socket = io.io(`http://localhost:5003`)
        this.socket = io.io(`https://slamdunkforum.onrender.com`)
        this.socket.emit('thread', this.id, comment, false)
        this.displayThread()
      }, error: (error) => {
        error.statusText === 'Unauthorized' ? this.toast.info('You need to sign in first') : error
      }
    })
  }
}

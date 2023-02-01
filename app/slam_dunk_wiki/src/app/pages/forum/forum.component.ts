import { Component, OnInit } from '@angular/core';
import { faPlusSquare } from '@fortawesome/free-regular-svg-icons';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import * as io from 'socket.io-client'


import { CreateForum } from '../../interfaces/CreateForum'
import { MemberService }  from '../../services/member/member.service'
import { ForumService } from '../../services/forum/forum.service';
import { UserService } from 'src/app/services/user/user.service';
@Component({
  selector: 'app-forum',
  templateUrl: './forum.component.html',
  styleUrls: ['./forum.component.css']
})
export class ForumComponent implements OnInit {

  faPlusSquare = faPlusSquare
  title!: string
  content!: string
  private socket: any;

  constructor(protected member: MemberService, 
    protected user: UserService, 
    private forumService: ForumService, 
    private router: Router,
    private toast: ToastrService) { }

  ngOnInit(): void {
    
  }

  onCreateForum() {
    const forum: CreateForum = {
      title: this.title,
      primary_author: this.user.getUsername(),
      body: [
        {
          author: this.user.getUsername(),
          content: this.content
        }
      ]
    }
    this.forumService.createForum(forum).subscribe({
      next: (data) => {
        this.router.navigate(['/forum/thread', data._id])
        // this.socket = io.io(`http://localhost:5003`)
        this.socket = io.io(`https://slamdunkforum.onrender.com`)
        this.socket.emit('forum', forum, data._id, false)
      },
      error: () => {
        this.toast.error('Something went wrong')
      }
    })
    
  }
}

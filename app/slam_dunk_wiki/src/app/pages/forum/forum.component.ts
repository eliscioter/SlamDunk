import { Component, OnInit } from '@angular/core';
import { faPlusSquare } from '@fortawesome/free-regular-svg-icons';
import { Router } from '@angular/router';
import { ReactiveFormsModule } from '@angular/forms';

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

  constructor(protected member: MemberService, protected user: UserService, private forumService: ForumService, private router: Router) { }

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
      },
      error: (e) => {
        alert('Something went wrong')
      }
    })
    
  }
}

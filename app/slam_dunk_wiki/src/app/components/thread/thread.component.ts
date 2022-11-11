import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { faEdit, faTrash } from '@fortawesome/free-solid-svg-icons';

import { UserService } from 'src/app/services/user/user.service';
import { ForumService } from 'src/app/services/forum/forum.service';
import { Body } from '../../interfaces/ForumBody';
@Component({
  selector: 'app-thread',
  templateUrl: './thread.component.html',
  styleUrls: ['./thread.component.css']
})
export class ThreadComponent implements OnInit {

  faEdit = faEdit;
  faTrash = faTrash;
  id!: string;
  @Input() forum: Body[] = []

  constructor(protected user: UserService, private forumService: ForumService, private route: ActivatedRoute) {
    this.id = this.route.snapshot.params['id'];
  }

  ngOnInit(): void { }


  verifyRole(): boolean {
    return this.user.getRole()?.includes('MODERATOR')
  }

  onDelete(forum: Body) {
    this.forumService.deleteComment(this.id, forum).subscribe({
      next: () => {
        this.forum = this.forum.filter(forum => forum._id !== forum._id)
        location.reload()
      },
      error: (e) => console.log(e)
    })
  }
}

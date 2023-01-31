import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { faEdit, faTrash } from '@fortawesome/free-solid-svg-icons';
import { ToastrService } from 'ngx-toastr';
import * as io from 'socket.io-client'

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
  private socket: any;

  constructor(protected user: UserService, private forumService: ForumService, private route: ActivatedRoute, private toast: ToastrService) {
    this.id = this.route.snapshot.params['id'];
  }

  ngOnInit(): void { }


  verifyRole(): boolean {
    return this.user.getRole()?.includes('MODERATOR')
  }

  onDelete(deletedComment: Body) {
    this.socket = io.io(`http://localhost:5003`);

    this.forumService.deleteComment(this.id, deletedComment).subscribe({
      next: () => {
        this.forum = this.forum.filter(forum => forum._id !== deletedComment._id)
        this.socket.emit('thread', this.id, this.forum, true)
        this.toast.success(`${deletedComment.content} deleted successfully`)
      },
      error: () => this.toast.error('Something went wrong')
    })
  }
}

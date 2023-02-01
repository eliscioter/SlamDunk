import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { faTrash } from '@fortawesome/free-solid-svg-icons';
import { ToastrService } from 'ngx-toastr';
import * as io from 'socket.io-client'

import { UserService } from '../../services/user/user.service';
import { ForumService } from '../../services/forum/forum.service';
import { Forum } from '../../interfaces/Forum';
@Component({
  selector: 'app-forums',
  templateUrl: './forums.component.html',
  styleUrls: ['./forums.component.css']
})
export class ForumsComponent implements OnInit {

  forums: Forum[] = []
  forumCreated: string[] = []
  forum_id!: string
  forum_author!: string
  faTrash = faTrash;
  private socket: any;

  constructor(private forum: ForumService, protected user: UserService, private router: Router, private toast: ToastrService) { }

  ngOnInit(): void {
    this.displayForums()
  }

  displayForums() {
    // this.socket = io.io(`http://localhost:5003`)
    this.socket = io.io(`https://slamdunkforum.onrender.com`)
    
    this.forum.getForums().subscribe({
      next: (data) => {
        this.socket.on('receive-forum', (forumContent: Forum, id: string) => {
          this.forums.unshift({...forumContent, _id: id})
        })
        this.socket.on('receive-new-forums', (forums: Forum[]) => {
          this.forums.splice(0, this.forums.length, ...forums)
        })
        this.forums = data.reverse()
        for (let item = 0; item < data.length; item++) {
          this.forum_id = data[item]._id
          this.forumCreated.push(new Date(data[item].createdAt).toUTCString())
          
        }
      }, error: () => this.toast.error('Something went wrong')
    })
  }

  verifyAuth(id: string) {
    if(!this.user.isLoggedIn()) return this.toast.info('You must be logged in to see the thread')
    else return this.router.navigate(['/forum/thread',id])
  }

  verifyRole(): boolean {
    return this.user.getRole()?.includes('MODERATOR')
  }

  onDelete(deletedForum: Forum) {
    // this.socket = io.io(`http://localhost:5003`)
    this.socket = io.io(`https://slamdunkforum.onrender.com`)

    this.forum.deleteForum(deletedForum).subscribe({
      next: () => {
        this.forums = this.forums.filter(forum => forum._id !== deletedForum._id)
        this.socket.emit('forum', this.forums, deletedForum._id ,true)
        this.toast.success(`${deletedForum.title} deleted successfully`)
      },
      error: () => this.toast.error('Something went wrong')
    })
  }
}

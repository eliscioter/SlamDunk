import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { faTrash } from '@fortawesome/free-solid-svg-icons';

import { MemberService } from '../../services/member/member.service';
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

  constructor(private forum: ForumService, protected member: MemberService, private router: Router) { }

  ngOnInit(): void {
    this.forum.getForums().subscribe({
      next: (data) => {
            this.forums = data.reverse()
            for (let item = 0; item < data.length; item++) {
              this.forum_id = (data[item]._id)
              this.forumCreated.push(new Date(data[item].createdAt).toUTCString())
            }
      }
    })
  }

  verifyAuth(id: string) {
    if(!this.member.isLoggedIn()) return alert('You need to sign in first to see the forum thread')
    else return this.router.navigate(['/forum/thread',id])
  }

  verifyRole(): boolean {
    return this.member.getRole().includes('MODERATOR')
  }

  onDelete(forum: Forum) {
    console.log(forum._id)
    this.forum.deleteForum(forum).subscribe({
      next: () => {
        this.forums = this.forums.filter(forum => forum._id !== forum._id)
        location.reload()
      },
      error: (e) => console.log(e)
    })
  }
}

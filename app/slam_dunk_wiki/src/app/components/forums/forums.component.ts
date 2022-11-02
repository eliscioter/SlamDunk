import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

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

  constructor(private forum: ForumService, private member: MemberService, private router: Router) { }

  ngOnInit(): void {
    this.forum.getForums().subscribe( (data) => {
        this.forums = data
        for (let item = 0; item < data.length; item++) {
          this.forum_id = (data[item]._id)
          this.forumCreated.push(new Date(data[item].createdAt).toUTCString())
        }
    } );
  }

  verifyAuth(id: string) {
    if(!this.member.isLoggedIn()) return alert('You need to sign in first to see the forum thread')
    else return this.router.navigate(['/forum/thread',id])
  }

}

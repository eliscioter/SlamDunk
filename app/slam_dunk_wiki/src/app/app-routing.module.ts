import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { HomeComponent } from './pages/home/home.component';
import { ForumComponent } from './pages/forum/forum.component';
import { ForumThreadComponent } from './pages/forum-thread/forum-thread.component';
import { PlayersComponent } from './pages/players/players.component';
import { TraitsComponent } from './pages/traits/traits.component';
const routes: Routes = [
  { path: '', component: HomeComponent},
  { path: 'forum', component: ForumComponent},
  { path: 'forum/thread', component: ForumThreadComponent},
  { path: 'players', component: PlayersComponent},
  { path: 'traits', component: TraitsComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

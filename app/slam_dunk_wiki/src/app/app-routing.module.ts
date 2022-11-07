import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { HomeComponent } from './pages/home/home.component';
import { ForumComponent } from './pages/forum/forum.component';
import { ForumThreadComponent } from './pages/forum-thread/forum-thread.component';
import { PlayersComponent } from './pages/players/players.component';
import { AboutComponent } from './pages/about/about.component';
import { RegisterComponent } from './components/register/register.component';
import { TraitsComponent } from './pages/traits/traits.component';

const routes: Routes = [
  { path: '', component: HomeComponent},
  { path: 'forum', component: ForumComponent},
  { path: 'forum/thread/:id', component: ForumThreadComponent},
  { path: 'players', component: PlayersComponent},
  { path: 'about', component: AboutComponent},
  { path: 'register', component: RegisterComponent},
  { path: 'traits', component: TraitsComponent}

];

@NgModule({
  imports: [RouterModule.forRoot(routes,{ onSameUrlNavigation: 'reload' })],
  exports: [RouterModule]
})
export class AppRoutingModule { }

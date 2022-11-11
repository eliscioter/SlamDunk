import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AuthGuard } from './guard/auth.guard';
import { HomeComponent } from './pages/home/home.component';
import { ForumComponent } from './pages/forum/forum.component';
import { ForumThreadComponent } from './pages/forum-thread/forum-thread.component';
import { PlayersComponent } from './pages/players/players.component';
import { AboutComponent } from './pages/about/about.component';
import { RegisterComponent } from './components/register/register.component';
import { LoginComponent } from './admin/pages/login/login.component';
import { Title } from '@angular/platform-browser';
import { TraitsComponent } from './pages/traits/traits.component';
import { ContactComponent } from './pages/contact/contact.component';
import { DefenseComponent } from './pages/traits/defense/defense.component';
import { TrickComponent } from './pages/traits/trick/trick.component';

const routes: Routes = [
  { path: '', component: HomeComponent, data: {title: 'Slam Dunk Wiki'}},
  { path: 'forum', component: ForumComponent, data: {title: 'Forums'}},
  { path: 'forum/thread/:id', component: ForumThreadComponent, data: {title: 'Thread'},canActivate: [AuthGuard]},
  { path: 'players', component: PlayersComponent, data: {title: 'Players'}},
  { path: 'about', component: AboutComponent, data: {title: 'About'}},
  { path: 'register', component: RegisterComponent, data: {title: 'Register'}},
  { path: 'admin/login', component: LoginComponent, data: {title: 'Admin | Login'}},
  { path: 'traits/offense', component: TraitsComponent, data: {title: 'Traits | Offense'}},
  { path: 'contact', component: ContactComponent, data: {title: 'Contact'}},
  { path: 'traits/defense', component: DefenseComponent, data: {title: 'Traits | Defense'}},
  { path: 'traits/trick', component: TrickComponent, data: {title: 'Traits | Trick'}},

];

@NgModule({
  imports: [RouterModule.forRoot(routes,{ onSameUrlNavigation: 'reload' })],
  exports: [RouterModule],
  providers: [Title]
})
export class AppRoutingModule { }

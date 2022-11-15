import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AuthGuard } from './guard/auth.guard';
import { AdminGuard } from './guard/admin/admin.guard';
import { LoginGuard } from './guard/login/login.guard';
import { HomeComponent } from './pages/home/home.component';
import { ForumComponent } from './pages/forum/forum.component';
import { ForumThreadComponent } from './pages/forum-thread/forum-thread.component';
import { PlayersComponent } from './pages/players/players.component';
import { AboutComponent } from './pages/about/about.component';
import { RegisterComponent } from './components/register/register.component';
import { LoginComponent } from './admin/pages/login/login.component';
import { Title } from '@angular/platform-browser';
import { TraitsComponent } from './pages/traits/traits.component';
import { CreatePlayerComponent } from './admin/pages/create-player/create-player.component';
import { ContactComponent } from './pages/contact/contact.component';
import { DefenseComponent } from './pages/traits/defense/defense.component';
import { TrickComponent } from './pages/traits/trick/trick.component';
import { DashboardComponent } from './admin/pages/dashboard/dashboard.component';
import { PlayersAdminComponent } from './admin/pages/players-admin/players-admin.component';
import { TraitsAdminComponent } from './admin/pages/traits-admin/traits-admin.component';
import { ModifyPlayerComponent } from './admin/pages/modify-player/modify-player.component';
import { ErrorComponent } from './pages/error/error.component';
import { PlayerDasboardComponent} from './pages/player-dasboard/player-dasboard.component';
import { ThanksComponent } from './pages/thanks/thanks.component';

const routes: Routes = [
  { path: '', component: HomeComponent, data: {title: 'Slam Dunk Wiki'}},
  { path: 'forum', component: ForumComponent, data: {title: 'Forums'}},
  { path: 'forum/thread/:id', component: ForumThreadComponent, data: {title: 'Thread'}, canActivate: [AuthGuard]},
  { path: 'players', component: PlayersComponent, data: {title: 'Players'}},
  { path: 'about', component: AboutComponent, data: {title: 'About'}},
  { path: 'traits', component: TraitsComponent, data: {title: 'Traits'}},
  { path: 'register', component: RegisterComponent, data: {title: 'Register'}},
  { path: 'traits/offense', component: TraitsComponent, data: {title: 'Traits | Offense'}},
  { path: 'traits/defense', component: DefenseComponent, data: {title: 'Traits | Defense'}},
  { path: 'traits/trick', component: TrickComponent, data: {title: 'Traits | Trick'}},
  { path: 'contact', component: ContactComponent, data: {title: 'Contact'}},
  { path: 'admin/login', component: LoginComponent, data: {title: 'Admin | Login'}, canActivate: [LoginGuard] },
  { path: 'create-player', component: CreatePlayerComponent, data: {title: 'Admin | Create Player'}, canActivate: [AdminGuard] },
  { path: 'modify/:_id', component: ModifyPlayerComponent, data: {title: 'Admin | Modify'}, canActivate: [AdminGuard]},
  { path: 'dashboard', component: DashboardComponent, data: {title: 'Admin | Dashboard'}, canActivate: [AdminGuard],
    children: [
      { path: 'admin/players', component: PlayersAdminComponent, data: {title: 'Admin | Players'}, canActivate: [AdminGuard] },
      { path: 'admin/traits', component: TraitsAdminComponent, data: {title: 'Admin | Traits'}, canActivate: [AdminGuard] },
    ]  
  },
  { path: 'player/:id', component: PlayerDasboardComponent},
  { path: 'thanks', component: ThanksComponent },
  { path: '**', component: ErrorComponent, data: { title: 'Error' }}
  
];

@NgModule({
  imports: [RouterModule.forRoot(routes,{ onSameUrlNavigation: 'reload' })],
  exports: [RouterModule],
  providers: [Title]
})
export class AppRoutingModule { }
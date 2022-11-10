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
import { CreateComponent } from './admin/pages/create/create.component';
import { ContactComponent } from './pages/contact/contact.component';
import { DashboardComponent } from './admin/pages/dashboard/dashboard.component';
import { PlayersAdminComponent } from './admin/pages/players-admin/players-admin.component';
import { TraitsAdminComponent } from './admin/pages/traits-admin/traits-admin.component';
import { ModifyComponent } from './admin/pages/modify/modify.component';
import { ErrorComponent } from './pages/error/error.component';

const routes: Routes = [
  { path: '', component: HomeComponent, data: {title: 'Slam Dunk Wiki'}},
  { path: 'forum', component: ForumComponent, data: {title: 'Forums'}},
  { path: 'forum/thread/:id', component: ForumThreadComponent, data: {title: 'Thread'}, canActivate: [AuthGuard]},
  { path: 'players', component: PlayersComponent, data: {title: 'Players'}},
  { path: 'about', component: AboutComponent, data: {title: 'About'}},
  { path: 'traits', component: TraitsComponent, data: {title: 'Traits'}},
  { path: 'register', component: RegisterComponent, data: {title: 'Register'}},
  { path: 'contact', component: ContactComponent, data: {title: 'Contact'}},
  { path: 'admin/login', component: LoginComponent, data: {title: 'Admin | Login'}, canActivate: [LoginGuard] },
  { path: 'create', component: CreateComponent, data: {title: 'Admin | Create'}, canActivate: [AdminGuard] },
  { path: 'modify', component: ModifyComponent, data: {title: 'Admin | Modify'}, canActivate: [AdminGuard]},
  { path: 'dashboard', component: DashboardComponent, data: {title: 'Admin | Dashboard'}, canActivate: [AdminGuard],
    children: [
      { path: 'admin/players', component: PlayersAdminComponent, data: {title: 'Admin | Players'}, canActivate: [AdminGuard] },
      { path: 'admin/traits', component: TraitsAdminComponent, data: {title: 'Admin | Traits'}, canActivate: [AdminGuard] },
    ]  
  },
  
  { path: '**', component: ErrorComponent, data: { title: 'Error' }}

];

@NgModule({
  imports: [RouterModule.forRoot(routes,{ onSameUrlNavigation: 'reload' })],
  exports: [RouterModule],
  providers: [Title]
})
export class AppRoutingModule { }

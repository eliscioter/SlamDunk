import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { HomeComponent } from './pages/home/home.component';
import { ForumComponent } from './pages/forum/forum.component';
const routes: Routes = [
  { path: '', component: HomeComponent},
  { path: 'forum', component: ForumComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

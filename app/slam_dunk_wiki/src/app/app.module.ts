import { NgModule } from '@angular/core';
import { BrowserModule, Title } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HeaderComponent } from './components/header/header.component';
import { FooterComponent } from './components/footer/footer.component';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatDialogModule } from '@angular/material/dialog'
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { FormsModule } from '@angular/forms';
import {AutosizeModule} from 'ngx-autosize';

import { HomeComponent } from './pages/home/home.component';
import { ForumComponent } from './pages/forum/forum.component';
import { ForumsComponent } from './components/forums/forums.component';
import { ForumThreadComponent } from './pages/forum-thread/forum-thread.component';
import { ThreadComponent } from './components/thread/thread.component';
import { AboutComponent } from './pages/about/about.component';
import { PlayersComponent } from './pages/players/players.component';
import { RegisterComponent } from './components/register/register.component';
import { SignInComponent } from './components/sign-in/sign-in.component';
import { AuthInterceptor } from './interceptor/auth.interceptor';
import { LoginComponent } from './admin/pages/login/login.component';
import { TraitsComponent } from './pages/traits/traits.component';
import { ContactComponent } from './pages/contact/contact.component';
import { DefenseComponent } from './pages/traits/defense/defense.component';
import { TrickComponent } from './pages/traits/trick/trick.component';
import { DashboardComponent } from './admin/pages/dashboard/dashboard.component';
import { ErrorComponent } from './pages/error/error.component';
import { SidebarComponent } from './admin/components/sidebar/sidebar.component';
import { PlayersAdminComponent } from './admin/pages/players-admin/players-admin.component';
import { TraitsAdminComponent } from './admin/pages/traits-admin/traits-admin.component';
import { CreatePlayerComponent } from './admin/pages/create-player/create-player.component';
import { ModifyPlayerComponent } from './admin/pages/modify-player/modify-player.component';
import { PlayerDasboardComponent } from './components/player-dasboard/player-dasboard.component';

@NgModule({
  declarations: [
    AppComponent,
    HeaderComponent,
    FooterComponent,
    HomeComponent,
    ForumComponent,
    ForumsComponent,
    ForumThreadComponent,
    ThreadComponent,
    AboutComponent,
    PlayersComponent,
    RegisterComponent,
    SignInComponent,
    LoginComponent,
    TraitsComponent,
    ContactComponent,
    DefenseComponent,
    TrickComponent,
    DashboardComponent,
    ErrorComponent,
    SidebarComponent,
    PlayersAdminComponent,
    TraitsAdminComponent,
    CreatePlayerComponent,
    ModifyPlayerComponent,
    PlayerDasboardComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FontAwesomeModule,
    BrowserAnimationsModule,
    MatDialogModule,
    HttpClientModule,
    FormsModule,
    AutosizeModule
  ],
  providers: [
    {
      provide:  HTTP_INTERCEPTORS,
      useClass: AuthInterceptor,
      multi: true
    },
    Title,
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }

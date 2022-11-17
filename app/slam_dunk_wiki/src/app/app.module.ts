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
import { ToastrModule } from 'ngx-toastr'

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
import { PlayerDasboardComponent } from './pages/player-dasboard/player-dasboard.component';
import { PlayerInfoComponent } from './components/player-info/player-info.component';
import { PlayerAttributesComponent } from './components/player-attributes/player-attributes.component';
import { ThanksComponent } from './pages/thanks/thanks.component';
import { LoadingComponent } from './components/loading/loading.component';
import { NetworkInterceptor } from './interceptor/network/network.interceptor';

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
    PlayerInfoComponent,
    PlayerAttributesComponent,
    ThanksComponent,
    LoadingComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FontAwesomeModule,
    BrowserAnimationsModule,
    MatDialogModule,
    HttpClientModule,
    FormsModule,
    AutosizeModule,
    ToastrModule.forRoot({
      positionClass: 'toast-top-center', 
      preventDuplicates: true,
      timeOut: 5000,
      closeButton: true,
      progressBar: true
    })
  ],
  providers: [
    {
      provide:  HTTP_INTERCEPTORS,
      useClass: AuthInterceptor,
      multi: true
    },
    {
      provide:  HTTP_INTERCEPTORS,
      useClass: NetworkInterceptor,
      multi: true
    },
    Title,
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }

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
import { CreateComponent } from './admin/pages/create/create.component';
import { TraitsComponent } from './pages/traits/traits.component';
import { ContactComponent } from './pages/contact/contact.component';
import { DefenseComponent } from './pages/traits/defense/defense.component';
import { TrickComponent } from './pages/traits/trick/trick.component';

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
    CreateComponent,
    TraitsComponent,
    ContactComponent,
    DefenseComponent,
    TrickComponent,
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

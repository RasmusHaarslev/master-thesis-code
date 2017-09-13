import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import {MdInputModule, MdButtonModule} from '@angular/material';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { FlexLayoutModule } from '@angular/flex-layout';

import { DndModule } from 'ng2-dnd';

import { AppComponent } from './app.component';
import { VotingComponent } from './voting/voting.component';
import { DragListComponent } from './drag-list/drag-list.component';
import { HomeComponent } from './home/home.component';

const appRoutes: Routes = [
  { path: 'voting', component: VotingComponent },
  { path: '**', component: HomeComponent }
];

@NgModule({
  declarations: [
    AppComponent,
    VotingComponent,
    DragListComponent,
    HomeComponent
  ],
  imports: [
    BrowserModule,
    MdInputModule,
    MdButtonModule,
    BrowserAnimationsModule,
    FlexLayoutModule,
    DndModule.forRoot(),
    RouterModule.forRoot(
      appRoutes,
      { enableTracing: false } // <-- debugging purposes only
    )
  ],
  exports: [BrowserModule],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }

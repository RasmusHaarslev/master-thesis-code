import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { FormsModule }   from '@angular/forms';
import {HttpClientModule} from '@angular/common/http';

import {
  MdInputModule,
  MdButtonModule,
  MdListModule} from '@angular/material';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { FlexLayoutModule } from '@angular/flex-layout';

import { DndModule } from 'ng2-dnd';

import { AppComponent } from './app.component';
import { VotingComponent } from './voting/voting.component';
import { DragListComponent } from './drag-list/drag-list.component';
import { HomeComponent } from './home/home.component';
import { CreateVotingComponent } from './create-voting/create-voting.component';
import { VotingResultComponent } from './voting-result/voting-result.component';

const appRoutes: Routes = [
  { path: 'voting/:code', component: VotingComponent },
  { path: 'voting', component: CreateVotingComponent },
  { path: 'result/:code', component: VotingResultComponent },
  { path: '**', component: HomeComponent }
];

@NgModule({
  declarations: [
    AppComponent,
    VotingComponent,
    DragListComponent,
    HomeComponent,
    CreateVotingComponent,
    VotingResultComponent
  ],
  imports: [
    BrowserModule,
    MdInputModule,
    MdButtonModule,
    MdListModule,
    BrowserAnimationsModule,
    FlexLayoutModule,
    FormsModule,
    HttpClientModule,
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

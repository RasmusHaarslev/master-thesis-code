import { Component, OnInit } from '@angular/core';
import {Router} from "@angular/router";

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent {
  public code: string;

  constructor(private router: Router) { }

  enterVoting(){
    this.router.navigate(['voting', this.code]);
  }


}

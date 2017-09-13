import { Component, OnInit } from '@angular/core';
import {ActivatedRoute, Params} from "@angular/router";

@Component({
  selector: 'app-voting',
  templateUrl: './voting.component.html',
  styleUrls: ['./voting.component.css']
})
export class VotingComponent implements OnInit {

  candidateTest: Array<string>;
  titleTest: string;

  constructor(private activatedRoute: ActivatedRoute) {
    this.candidateTest = ['test', 'test2', 'test3'];
    this.titleTest = "Film"
  }


  ngOnInit() {
    this.activatedRoute.params.subscribe((params: Params) => {
      let code = params['code'];
      console.log(code);
    });
  }


}

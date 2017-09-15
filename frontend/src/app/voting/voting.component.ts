import { Component, OnInit } from '@angular/core';
import {ActivatedRoute, Params} from "@angular/router";
import {HttpClient} from "@angular/common/http";

@Component({
  selector: 'app-voting',
  templateUrl: './voting.component.html',
  styleUrls: ['./voting.component.css']
})
export class VotingComponent implements OnInit {

  candidateTest: Array<string>;
  titleTest: string;

  constructor(private activatedRoute: ActivatedRoute,
              private http: HttpClient) {
    this.candidateTest = ['test', 'test2', 'test3'];
    this.titleTest = "Film"
  }


  ngOnInit() {
    this.activatedRoute.params.subscribe((params: Params) => {
      let code = params['code'];
      this.http.get('api/voting/' + code).subscribe(data => {
        let result = data['results'];
      });
    });
  }


}

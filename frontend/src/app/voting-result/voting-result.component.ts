import { Component, OnInit } from '@angular/core';
import {ActivatedRoute, Params} from "@angular/router";
import {HttpClient} from "@angular/common/http";

@Component({
  selector: 'app-voting-result',
  templateUrl: './voting-result.component.html',
  styleUrls: ['./voting-result.component.css']
})
export class VotingResultComponent implements OnInit {
  public options: Array<string>;
  constructor(private activatedRoute: ActivatedRoute,
              private http: HttpClient) { }

  ngOnInit() {
    this.activatedRoute.params.subscribe((params: Params) => {
      let code = params['code'];
      this.http.get('api/votings/' + code).subscribe(data => {
        this.options = data['alternatives'];
      });
    })
  }

}

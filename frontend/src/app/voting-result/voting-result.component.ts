import { Component, OnInit } from '@angular/core';
import {ActivatedRoute, Params} from "@angular/router";
import {HttpClient} from "@angular/common/http";

@Component({
  selector: 'app-voting-result',
  templateUrl: './voting-result.component.html',
  styleUrls: ['./voting-result.component.css']
})
export class VotingResultComponent implements OnInit {
  public schulzeResult;
  public kemenieResult;
  constructor(private activatedRoute: ActivatedRoute,
              private http: HttpClient) { }

  ngOnInit() {
    this.activatedRoute.params.subscribe((params: Params) => {
      let code = params['code'];
      this.http.get('api/votings/'+ code+'/schulzes').subscribe(data => {
        this.schulzeResult = data;
      });
      this.http.get('api/votings/'+ code+'/kemenies').subscribe(data => {
        this.kemenieResult = data;
      });
    })
  }

}

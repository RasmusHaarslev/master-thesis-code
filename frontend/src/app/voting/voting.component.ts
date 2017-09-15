import { Component, OnInit } from '@angular/core';
import {ActivatedRoute, Params, Router} from "@angular/router";
import {HttpClient} from "@angular/common/http";

@Component({
  selector: 'app-voting',
  templateUrl: './voting.component.html',
  styleUrls: ['./voting.component.css']
})
export class VotingComponent implements OnInit {

  alternatives: Array<string>;
  title: string;
  private code: string;

  constructor(private activatedRoute: ActivatedRoute,
              private http: HttpClient,
              private router: Router) {}


  submitVote(): any {
    let vote: any = {
      'preference': {
        'preference': this.alternatives
      }
    };
    this.http.post('api/votings/'+ this.code + '/preferences', vote).subscribe(data => {
      this.router.navigate(['result', this.code]);
    });
  }

  ngOnInit() {
    this.activatedRoute.params.subscribe((params: Params) => {
      let code = params['code'];
      this.http.get('api/votings/' + code).subscribe(data => {
        this.alternatives = data['alternatives'];
        this.title = data['title'];
        this.code = data['code'];
      });
    });
  }


}

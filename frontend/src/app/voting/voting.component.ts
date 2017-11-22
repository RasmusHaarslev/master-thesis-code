import { Component, OnInit } from '@angular/core';
import {ActivatedRoute, Params, Router} from "@angular/router";
import {HttpClient} from "@angular/common/http";

@Component({
  selector: 'app-voting',
  templateUrl: './voting.component.html',
  styleUrls: ['./voting.component.css']
})
export class VotingComponent implements OnInit {

  alternatives: any;
  currentRound: number = 0;
  preferences: any = {}
  movie_preferences: Array<string>;
  time_preferences: Array<string>;
  cinema_preferences: Array<string>;
  upForVote: Array<string>;
  title: string;
  question: string;
  private code: string;

  constructor(private activatedRoute: ActivatedRoute,
              private http: HttpClient,
              private router: Router) {}



  vote(): void {
    console.log(this.currentRound)
    switch(this.currentRound) {
      case 0:
        this.preferences['time_preferences'] = this.upForVote;
        this.upForVote =  this.alternatives['movies']
        this.currentRound++;
        break;
      case 1:
        this.preferences['movie_preferences'] = this.upForVote;
        this.upForVote =  this.alternatives['cinemas']
        this.currentRound++;
        break;
      case 2:
        this.preferences['cinema_preferences'] = this.upForVote;
        this.submitVote();
        break;
      default:
        break;
    }
  }

  submitVote(): any {
    let vote: any = {
      'preference': {
        'preference': this.preferences
      }
    };
    console.log(vote);
    this.http.post('api/votings/'+ this.code + '/preferences', vote).subscribe(data => {
      this.router.navigate(['result', this.code]);
    });
  }


  ngOnInit() {
    this.activatedRoute.params.subscribe((params: Params) => {
      let code = params['code'];
      this.http.get('api/votings/' + code).subscribe(data => {
        console.log(data['alternatives']['times'])
        this.alternatives = data['alternatives'];
        this.upForVote = this.alternatives['times']
        this.title = data['title'];
        this.question = data['question']
        this.code = data['code'];
      });
    });
  }


}

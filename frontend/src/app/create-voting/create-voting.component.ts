import {Component} from '@angular/core';
import { Router } from '@angular/router';
import {HttpClient} from "@angular/common/http";

@Component({
  selector: 'app-create-voting',
  templateUrl: './create-voting.component.html',
  styleUrls: ['./create-voting.component.css']
})
export class CreateVotingComponent{
  public options: Array<string>  = [];
  public option: string;
  public title: string;
  public question: string;

  constructor(private http: HttpClient,
              private router: Router) { }

  addOption(option: string): void {
    this.options.push(option);
    this.option = '';
  }

  removeOption(index: number): void {
    this.options.splice(index,1)
  }

  createVoting(): void {
    let voting: any = {
      'alternatives': this.options,
      'title': this.title,
      'question': this.question
    };
    // Make the HTTP request:
    this.http.post('api/votings',voting).subscribe(data => {
      this.router.navigate(['voting', data['code']]);
    });
  }

}

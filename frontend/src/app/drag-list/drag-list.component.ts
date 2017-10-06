import {AfterViewChecked, Component, Input, OnInit} from '@angular/core';



@Component({
  selector: 'app-drag-list',
  templateUrl: './drag-list.component.html',
  styleUrls: ['./drag-list.component.css']
})
export class DragListComponent implements OnInit{
  ngOnInit(): void {
    var el = document.getElementsByTagName("md-list-item");
    console.log(el);
    console.log(el[0]);
  }

  @Input() candidates: Array<string>;

  constructor(){

    //el.addEventListener("touchstart", handleStart, false);
  }
}


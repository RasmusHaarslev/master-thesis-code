import {Component, HostListener, Inject, OnInit} from '@angular/core';


@Component({
  selector: 'app-drag-list',
  templateUrl: './drag-list.component.html',
  styleUrls: ['./drag-list.component.css']
})
export class DragListComponent{

  listOne: Array<string> = ['Coffee', 'Orange Juice', 'Red Wine', 'Unhealty drink!', 'Water'];
}


import {Component, HostListener, Inject, OnInit} from '@angular/core';


@Component({
  selector: 'app-drag-list',
  templateUrl: './drag-list.component.html',
  styleUrls: ['./drag-list.component.css']
})
export class DragListComponent implements OnInit {
  private dragSrcEl = null;

  constructor() {

  }

  public handleDragStart(e) {
    // Target (this) element is the source node.
    this.dragSrcEl = this;
    console.log(this);
    e.dataTransfer.effectAllowed = 'move';
    //e.dataTransfer.setData('text/html', this.outerHTML);

    //this.classList.add('dragElem');
  }

  public handleDragOver(e) {
    if (e.preventDefault) {
      e.preventDefault(); // Necessary. Allows us to drop.
    }
    //this.classList.add('over');

    e.dataTransfer.dropEffect = 'move';  // See the section on the DataTransfer object.

    return false;
  }

  public handleDragEnter(e) {
  // this / e.target is the current hover target.
  }

  public handleDragLeave(e) {
    //this.classList.remove('over');  // this / e.target is previous target element.
  }

  public handleDrop(e) {
  if (e.stopPropagation) {
    e.stopPropagation(); // Stops some browsers from redirecting.
  }

  // Don't do anything if dropping the same column we're dragging.
  if (this.dragSrcEl != this) {
    // Set the source column's HTML to the HTML of the column we dropped on.
    console.log(this.dragSrcEl);
    console.log(this);
    //dragSrcEl.innerHTML = this.innerHTML;
    //this.innerHTML = e.dataTransfer.getData('text/html');
    //this.parentNode.removeChild(dragSrcEl);
    var dropHTML = e.dataTransfer.getData('text/html');
    //this.insertAdjacentHTML('beforebegin',dropHTML);
    //var dropElem = this.previousSibling;
    //this.addDnDHandlers(dropElem);

  }
  //this.classList.remove('over');
  return false;
  }

  public handleDragEnd(e) {
    // this/e.target is the source node.
    //this.classList.remove('over');

    /*[].forEach.call(cols, function (col) {
     col.classList.remove('over');
     });*/
  }

  ngOnInit() {
    var cols = document.querySelectorAll('.column');
    [].forEach.call(cols, (e) => {this.addDnDHandlers(e)});
  }

  private addDnDHandlers(elem) {
    elem.addEventListener('dragstart', this.handleDragStart, false);
    elem.addEventListener('dragenter', this.handleDragEnter, false)
    elem.addEventListener('dragover', this.handleDragOver, false);
    elem.addEventListener('dragleave', this.handleDragLeave, false);
    elem.addEventListener('drop', this.handleDrop, false);
    elem.addEventListener('dragend', this.handleDragEnd, false);

  }



}

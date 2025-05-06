import { Component, OnInit } from '@angular/core';

interface Track {
  id: string;
  name: string;
}

@Component({
  selector: 'app-liked-track-list',
  imports: [],
  templateUrl: './liked-track-list.component.html',
  styleUrl: './liked-track-list.component.scss'
})
export class LikedTrackListComponent implements OnInit {
  constructor() {}

  ngOnInit(): void {
    this.loadData();
  }

  private loadData() {}
}

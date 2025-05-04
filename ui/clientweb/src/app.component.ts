import { ActivityService } from './app/service/activity.service';
import { Component, OnInit } from '@angular/core';
import { Router, RouterModule } from '@angular/router';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './app.component.html'
})
export class AppComponent implements OnInit {
  constructor(private readonly activityService: ActivityService) {}

  ngOnInit(): void {
    this.loadData();
  }

  private loadData(): void {
    this.activityService.userStats.subscribe(console.log);
  }
}

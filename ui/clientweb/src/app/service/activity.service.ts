import { Injectable } from '@angular/core';
import { flatMap, Observable, Subject } from 'rxjs';
import { environment } from '../../environment/environment';
import { ActivityDto } from '../dto/activity-dto';

@Injectable({
  providedIn: 'root'
})
export class ActivityService {
  private websocket: WebSocket | null = null;
  private messageSubject: Subject<string> = new Subject();

  constructor() {}

  private connect(): void {
    this.websocket = new WebSocket(`${environment.activityWsBaseUrl}/v1/ws`);

    this.websocket.onmessage = (event) => {
      this.messageSubject.next(event.data);
    };

    this.websocket.onerror = (error) => {
      console.error('WebSocket error:', error);
    };

    this.websocket.onclose = () => {
      console.warn('WebSocket closed');
    };
  }

  get message() {
    return this.messageSubject.asObservable();
  }

  send(activityDto: ActivityDto) {
    if (!this.websocket) {
      this.connect();
    }
    let bufferSecond = 1000;
    const trySend = () => {
      return window.setTimeout(() => {
        if (this.websocket) {
          if (this.websocket.readyState === WebSocket.OPEN) {
            this.websocket.send(JSON.stringify(activityDto));
            return;
          } else {
            console.warn('WebSocket is not open');
            bufferSecond *= 1.5;
            trySend();
          }
        }
      }, bufferSecond);
    };
    trySend();
  }
}

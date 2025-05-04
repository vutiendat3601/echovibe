import { Injectable } from '@angular/core';
import { flatMap, Observable, Subject } from 'rxjs';
import { environment } from '../../environment/environment';
import { ActivityDto } from '../dto/activity-dto';
import { AuthService } from './auth.service';
import { HttpClient } from '@angular/common/http';
import { UserStatsDto } from '../dto/user-dto';
import { ResponseDto } from '../dto/response-dto';

@Injectable({
  providedIn: 'root'
})
export class ActivityService {
  private websocket: WebSocket | null = null;
  private websocketMessageSubject: Subject<string> = new Subject();
  private userStatsSubject: Subject<UserStatsDto> = new Subject();

  constructor(
    private readonly http: HttpClient,
    private readonly authService: AuthService
  ) {
    this.initialize();
  }

  private initialize(): void {
    this.getUserStats().subscribe((respDto) => {
      this.userStatsSubject.next(respDto.data);
    });
  }

  getUserStats(): Observable<ResponseDto<UserStatsDto>> {
    return this.http.get<ResponseDto<UserStatsDto>>(`${environment.activityBaseUrl}/v1/me/stats`);
  }

  send(activityDto: ActivityDto) {
    if (!this.websocket) {
      this.connectWebsocket();
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

  get userStats(): Observable<UserStatsDto> {
    return this.userStatsSubject.asObservable();
  }

  private connectWebsocket(): void {
    const jwt = this.authService.getAccessToken();
    if (jwt) {
      this.websocket = new WebSocket(`${environment.activityWsBaseUrl}/v1/ws?jwt=${jwt}`);

      this.websocket.onmessage = (event) => {
        this.websocketMessageSubject.next(event.data);
      };

      this.websocket.onerror = (error) => {
        console.error('WebSocket error:', error);
      };

      this.websocket.onclose = () => {
        console.warn('WebSocket closed');
      };
    }
  }

  get websocketMessage() {
    return this.websocketMessageSubject.asObservable();
  }
}

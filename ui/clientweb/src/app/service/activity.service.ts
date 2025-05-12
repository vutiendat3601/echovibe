import { Injectable } from '@angular/core';
import { OAuthStorage } from 'angular-oauth2-oidc';
import { environment } from '../../environment/environment';
import { MessageType } from './../constant/message-type';
import { ActivityDto, MessageResponseDto } from './../dto/activity-dto';
import { SystemService } from './system.service';

@Injectable({
  providedIn: 'root'
})
export class ActivityService {
  private websocket: WebSocket | null = null;
  private websocketMessageHandlersMap: Map<MessageType, ((message: MessageResponseDto) => void)[]> = new Map();
  constructor(
    private readonly oauthStorage: OAuthStorage,
    private readonly systemService: SystemService
  ) {}

  sendMessage(activityDto: ActivityDto) {
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

  addMessageHandler(type: MessageType, handler: (message: MessageResponseDto) => void) {
    const websocketMessageHandlers = this.websocketMessageHandlersMap.get(type);
    if (websocketMessageHandlers) {
      websocketMessageHandlers.push(handler);
    } else {
      this.websocketMessageHandlersMap.set(type, [handler]);
    }
  }

  private connectWebsocket(): void {
    const jwt = this.oauthStorage.getItem('access_token');
    const fingerprint = this.systemService.getFingerprint();
    let websocketUrl = `${environment.activityWsBaseUrl}/v1/ws?fingerprint=${fingerprint}`;
    if (jwt) {
      websocketUrl += `&jwt=${jwt}`;
    }
    this.websocket = new WebSocket(websocketUrl);
    this.websocket.onmessage = (event) => {
      const message: MessageResponseDto = JSON.parse(event.data) as MessageResponseDto;
      const handlers = this.websocketMessageHandlersMap.get(message.type) || [];
      for (const handle of handlers) {
        handle(message);
      }
    };

    this.websocket.onerror = (error) => {
      console.error('WebSocket error:', error);
    };

    this.websocket.onclose = () => {
      console.warn('WebSocket closed');
    };
  }
}

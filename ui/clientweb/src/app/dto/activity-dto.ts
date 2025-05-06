import { ActionType } from '../constant/action-type';
import { MessageType } from '../constant/message-type';

export interface ActivityDto {
  sessionId: string | null;
  aggregateId: string | null;
  type: ActionType;
  dataJson: object | null;
}

export interface MessageResponseDto {
  sessionId: string | null;
  aggregateId: string | null;
  type: MessageType;
  [key: string]: any;
}

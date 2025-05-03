import { ActionType } from '../constant/action-type';

export interface ActivityDto {
  sessionId: string | null;
  aggregateId: string | null;
  type: ActionType;
  dataJson: object | null;
}

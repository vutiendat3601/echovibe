export interface ResponseDto<T> {
  data: T[];
  status: string;
  message: string;
  timestamp: string;
}

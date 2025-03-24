import { Error } from '../exception/error';

export interface CommandResult {
  id: string | null;
  command: string | null;
  errors: Error[];
  isSuccessful: boolean;
  message: string;
}

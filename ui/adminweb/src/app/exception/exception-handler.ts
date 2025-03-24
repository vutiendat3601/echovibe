import { Injectable } from '@angular/core';
import { Error } from './error';

export interface Message {
  title: string;
  content: string;
}

@Injectable({
  providedIn: 'root'
})
export class ExceptionHandler {
  handle(error?: Error): Message {
    if (error?.businessRule) {
      return {
        title: error.businessRule.code,
        content: error.businessRule.content
      };
    }
    return {
      title: $localize`:@@DIALOG_LABEL_ERROR_SYSTEM:System error`,
      content: $localize`:@@MESSAGE_ERROR_SYSTEM:An unexpected error occurred. Please try again later.`
    };
  }
}

import { Injectable } from '@angular/core';
import { ClientJS } from 'clientjs';

@Injectable({
  providedIn: 'root'
})
export class SystemService {
  private clientJs = new ClientJS();

  getFingerprint() {
    return this.clientJs.getFingerprint();
  }
}

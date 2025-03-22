import { TestBed } from '@angular/core/testing';

import { UrlValidator } from './url.validator';

describe('UrlCheckService', () => {
  let service: UrlValidator;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(UrlValidator);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});

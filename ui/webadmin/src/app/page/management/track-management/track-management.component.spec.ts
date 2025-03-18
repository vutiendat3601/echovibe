import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TrackManagementComponent } from './track-management.component';

describe('TrackManagementComponent', () => {
  let component: TrackManagementComponent;
  let fixture: ComponentFixture<TrackManagementComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TrackManagementComponent]
    }).compileComponents();

    fixture = TestBed.createComponent(TrackManagementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

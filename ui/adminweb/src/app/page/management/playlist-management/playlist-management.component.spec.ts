import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PlaylistManagementComponent } from './playlist-management.component';

describe('PlaylistManagementComponent', () => {
  let component: PlaylistManagementComponent;
  let fixture: ComponentFixture<PlaylistManagementComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PlaylistManagementComponent]
    }).compileComponents();

    fixture = TestBed.createComponent(PlaylistManagementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

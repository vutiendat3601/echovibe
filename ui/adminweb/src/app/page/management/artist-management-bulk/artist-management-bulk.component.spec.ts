import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ArtistManagementBulkComponent } from './artist-management-bulk.component';

describe('ArtistManagementBulkComponent', () => {
  let component: ArtistManagementBulkComponent;
  let fixture: ComponentFixture<ArtistManagementBulkComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ArtistManagementBulkComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ArtistManagementBulkComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

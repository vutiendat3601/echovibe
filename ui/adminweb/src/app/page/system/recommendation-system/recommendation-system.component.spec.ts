import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RecommendationSystemComponent } from './recommendation-system.component';

describe('RecommendationSystemManagementComponent', () => {
  let component: RecommendationSystemComponent;
  let fixture: ComponentFixture<RecommendationSystemComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RecommendationSystemComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RecommendationSystemComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

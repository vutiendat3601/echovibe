import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NowPlayingBarComponent } from './now-playing-bar.component';

describe('NowPlayingBarComponent', () => {
  let component: NowPlayingBarComponent;
  let fixture: ComponentFixture<NowPlayingBarComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [NowPlayingBarComponent]
    }).compileComponents();

    fixture = TestBed.createComponent(NowPlayingBarComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

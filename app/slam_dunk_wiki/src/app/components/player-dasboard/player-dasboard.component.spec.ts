import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PlayerDasboardComponent } from './player-dasboard.component';

describe('PlayerDasboardComponent', () => {
  let component: PlayerDasboardComponent;
  let fixture: ComponentFixture<PlayerDasboardComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PlayerDasboardComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PlayerDasboardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

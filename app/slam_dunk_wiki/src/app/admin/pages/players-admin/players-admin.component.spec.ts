import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PlayersAdminComponent } from './players-admin.component';

describe('PlayersAdminComponent', () => {
  let component: PlayersAdminComponent;
  let fixture: ComponentFixture<PlayersAdminComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PlayersAdminComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PlayersAdminComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

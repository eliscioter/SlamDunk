import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TraitsAdminComponent } from './traits-admin.component';

describe('TraitsAdminComponent', () => {
  let component: TraitsAdminComponent;
  let fixture: ComponentFixture<TraitsAdminComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ TraitsAdminComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TraitsAdminComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

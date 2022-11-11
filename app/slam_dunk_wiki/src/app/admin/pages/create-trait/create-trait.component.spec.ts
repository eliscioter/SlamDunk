import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CreateTraitComponent } from './create-trait.component';

describe('CreateTraitComponent', () => {
  let component: CreateTraitComponent;
  let fixture: ComponentFixture<CreateTraitComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CreateTraitComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CreateTraitComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

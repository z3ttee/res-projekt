import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { BrowserModule } from '@angular/platform-browser';

import { DataComponent } from './data.component';
import {ReactiveFormsModule} from '@angular/forms'
import {HttpClientModule} from '@angular/common/http'
import {DummyService} from './services/dummy.service'

@NgModule({
  declarations: [
    DataComponent,
    
  ],
  imports: [
    CommonModule,
    ReactiveFormsModule,
    BrowserModule,
    HttpClientModule
  ],
  exports: [
    DataComponent
  ],
  providers: [
    DummyService
  ]
})
export class DummyDataModule { }

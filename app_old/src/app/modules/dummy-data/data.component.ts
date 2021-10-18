import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormGroup, Validators} from '@angular/forms'
import {DummyService} from './services/dummy.service'
import {USER} from './user'

@Component({
  selector: 'app-data',
  templateUrl: './data.component.html',
  styleUrls: ['./data.component.css']
})
export class DataComponent implements OnInit {

  form: FormGroup 
  users: USER[] = [];

  constructor(
      private formbuilder: FormBuilder,
      private dummyservice: DummyService
    ) { 
    this.form = this.formbuilder.group({
      firstName: formbuilder.control('', [Validators.required, Validators.minLength(3), Validators.maxLength(245), Validators.pattern('^[A-Za-zñÑáéíóúÁÉÍÓÚ ]+$')]),
      lastName: formbuilder.control('', [Validators.required, Validators.minLength(3), Validators.maxLength(245), Validators.pattern('^[A-Za-zñÑáéíóúÁÉÍÓÚ ]+$')]),
      age:formbuilder.control('', [Validators.required, Validators.minLength(1), Validators.maxLength(3),Validators.max(130) ,Validators.pattern('^[0-9]+$')])
    })
  }

  ngOnInit(): void {
    this.dummyservice.getAllUser().subscribe(
      data => this.users = data
   )
  }

  public checkValid(input:string){
    return this.form.get(input);
  }

  public newUser(){
    //console.log(this.form.value);
    
    this.dummyservice.postUser(this.form.value).subscribe(
      res => this.users.push(res)
    )

    this.dummyservice.getAllUser().subscribe(
      data => this.users = data
   )
    
  }
/*
  public schowUser(){
    this.dummyservice.getAllUser().subscribe(
      data => this.users = data
   )
  }
*/
}

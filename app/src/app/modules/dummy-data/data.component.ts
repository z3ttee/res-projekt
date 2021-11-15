import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormGroup, Validators} from '@angular/forms'
import {DummyService} from './services/dummy.service'
import {USER} from './model/user'

@Component({
  selector: 'app-data',
  templateUrl: './data.component.html',
  styleUrls: ['./data.component.scss']
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
    this.getAll();
  }

  public checkValid(input:string){
    return this.form.get(input);
  }

  public getAll() {
    this.dummyservice.getAllUser().toPromise().then(data => this.users = data)
  }

  public newUser(){  
    this.dummyservice.postUser(this.form.value).subscribe(res => {
      this.form.reset();

        for(let index = this.users.length; index >= 0; index--) {
          this.users[index + 1] = this.users[index];
        }

        this.users[0] = res;
        this.users = this.users.filter((user) => user);
        this.getAll();
      }
    )    
  }

  public async delUser(id: string | undefined) {
    console.log("deleting id: " + id);
    this.dummyservice.deleteUser(id).toPromise().then(() => {
      const index = this.users.findIndex((user) => user.id == id);
      this.users.splice(index, 1);
      this.getAll()
    })

  }
}

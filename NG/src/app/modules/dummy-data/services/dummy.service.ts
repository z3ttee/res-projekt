import { Injectable } from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http'
import {USER} from '../user'
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DummyService {

  url:string = 'http://localhost:3000/api';

  constructor(private httpclient:HttpClient) { }

   postUser(user: USER): Observable<USER>{
    console.log("send post request");
    return  this.httpclient.post<USER>(this.url,user);
  }

   getAllUser(): Observable<USER[]>{
    console.log("send get request");
    return  this.httpclient.get<USER[]>(this.url);
  }
}

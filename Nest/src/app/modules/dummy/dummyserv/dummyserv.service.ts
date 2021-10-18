import { Injectable } from '@nestjs/common';
import {UserRepository} from '../user.repository'
import { InjectRepository } from '@nestjs/typeorm';
import { UserDto} from '../dtos/users/users.dto'

@Injectable()
export class DummyservService {
	constructor(@InjectRepository(UserRepository) private userRepositary : UserRepository){

	}

	async getAllUser() :Promise<UserDto[]>{
		return await this.userRepositary.find();//select * from users
	}

	async createNewUserDB(user : UserDto) : Promise<UserDto>{
		console.log(user);
		return await this.userRepositary.save(user);
	}
}

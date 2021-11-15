import { Injectable } from '@nestjs/common';
import {UserRepository} from '../user.repository'
import { InjectRepository } from '@nestjs/typeorm';
import { UserDto} from '../dtos/users/users.dto'

@Injectable()
export class DummyservService {
	constructor(@InjectRepository(UserRepository) private userRepositary : UserRepository){}

	async getAllUser() :Promise<UserDto[]>{
		return await this.userRepositary.find({ order: { createdAt: "DESC" } });	//select * from users
	}

	async createNewUserDB(user : UserDto) : Promise<UserDto>{
		const result = await this.userRepositary.save(user);
		console.log("create user: ", result);
		return result;
	}

	async deleteUser(id: string) {
		console.log("delete user:", id);
		return this.userRepositary.delete({ id })
	}
}

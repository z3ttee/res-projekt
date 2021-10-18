import { Body, Controller, Get, HttpCode, Post, UsePipes, ValidationPipe } from '@nestjs/common';
import {UserDto} from '../dtos/users/users.dto';
import {DummyservService} from '../dummyserv/dummyserv.service'


@Controller('api')
export class DummyconController {

	constructor(private userService: DummyservService){}

	@Get()
	@UsePipes(ValidationPipe)
	async getAllUser(): Promise<UserDto[]>{
		return await this.userService.getAllUser();
	}

	@Post()
	@UsePipes(ValidationPipe)
	async postUser(@Body() userInfo: UserDto): Promise<UserDto>{
		console.log(userInfo);
		return await this.userService.createNewUserDB(userInfo) ;
	}
	
}

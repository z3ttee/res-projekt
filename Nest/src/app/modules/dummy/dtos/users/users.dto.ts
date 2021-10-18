import { IsNotEmpty, Length, Max, MAX, Min } from "class-validator";
import { PrimaryGeneratedColumn } from "typeorm";


export class UserDto{

	id:string;

	@IsNotEmpty({message: '<firstName> not set'})
	@Length(3,255,{message: '<lastName> Min 3 Max 255'})
	firstName: string;

	@IsNotEmpty({message: '<lastName> not set'})
	@Length(3,255,{message: '<lastName> Min 3 Max 255'})
	lastName:string;

	@IsNotEmpty({message: '<age> not set'})
	age: number;
}

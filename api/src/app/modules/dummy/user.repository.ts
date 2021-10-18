import { EntityRepository, Repository } from "typeorm";
import { User } from "./dtos/users/users.entity";

@EntityRepository(User)
export class UserRepository extends Repository<User>{

 }
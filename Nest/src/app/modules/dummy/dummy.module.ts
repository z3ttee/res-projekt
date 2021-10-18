import { Module } from '@nestjs/common';
import {DummyconController} from './dummycon/dummycon.controller'
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserRepository} from './user.repository'
import { DummyservService } from './dummyserv/dummyserv.service';
//import { User } from './user.entity';

@Module({
	imports: [TypeOrmModule.forFeature([UserRepository])],
	providers: [DummyservService],
	controllers: [DummyconController]
})
export class DummyModule {}

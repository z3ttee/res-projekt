import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { config } from './ormconfig';
import { DummyModule} from './modules/dummy/dummy.module'





@Module({
  imports: [
    TypeOrmModule.forRoot(config),
    DummyModule
  ],
  
})
export class AppModule {}

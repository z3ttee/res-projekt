import { NestFactory } from '@nestjs/core';
import { AppModule } from './app/app.module';
import { SwaggerModule, DocumentBuilder} from '@nestjs/swagger'

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {
    cors: true
  });
  const config = new DocumentBuilder()
  .setTitle('Eiersalat')
  .setDescription('CODE:EGG')
  .setVersion('0.0000001')
  .addTag('Robert verkauft die besten Eier')
  .build();

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('doc', app, document);
  //app.enableCors();
  await app.listen(3000);
}
bootstrap();

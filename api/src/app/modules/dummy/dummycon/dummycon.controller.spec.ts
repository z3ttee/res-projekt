import { Test, TestingModule } from '@nestjs/testing';
import { DummyconController } from './dummycon.controller';

describe('DummyconController', () => {
  let controller: DummyconController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [DummyconController],
    }).compile();

    controller = module.get<DummyconController>(DummyconController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});

import { Test, TestingModule } from '@nestjs/testing';
import { DummyservService } from './dummyserv.service';

describe('DummyservService', () => {
  let service: DummyservService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [DummyservService],
    }).compile();

    service = module.get<DummyservService>(DummyservService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});

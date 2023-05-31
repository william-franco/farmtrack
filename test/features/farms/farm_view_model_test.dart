// Dart imports:
import 'dart:io';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:farmtrack/src/constants/constants.dart';
import 'package:farmtrack/src/features/farms/models/animal_model.dart';
import 'package:farmtrack/src/features/farms/models/farm_animals_model.dart';
import 'package:farmtrack/src/features/farms/models/farm_model.dart';
import 'package:farmtrack/src/features/farms/repositories/farm_repository.dart';
import 'package:farmtrack/src/features/farms/view_models/farm_view_model.dart';
import 'package:farmtrack/src/services/farm_service.dart';

void main() {
  group('Test FarmViewModel class', () {
    const idFarm = 0;
    const nameFarm = 'Little farm';
    const tagAnimal = '123456';

    late FarmService farmService;
    late FarmRepository farmRepository;
    late FarmViewModel farmViewModel;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();

      // Directory used for store temporary the boxes
      const directoryPath = '/build/';

      final appDir = await Directory.current.createTemp(directoryPath);

      // Initializes the hive and points it to the temporary storage location
      Hive.init(appDir.path);

      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(FarmModelAdapter());
      }

      if (!Hive.isAdapterRegistered(2)) {
        Hive.registerAdapter(AnimalModelAdapter());
      }

      if (!Hive.isAdapterRegistered(3)) {
        Hive.registerAdapter(FarmAnimalsModelAdapter());
      }

      await Hive.openBox(Constants.farmBox);

      farmService = FarmService();
      farmRepository = FarmRepository(farmService: farmService);
      farmViewModel = FarmViewModel(farmRepository: farmRepository);
    });

    test('Test initial value', () {
      final listFarmAnimal = <FarmAnimalsModel>[];

      expect(farmViewModel.value, equals(listFarmAnimal));
    });

    test('Test of the create an item method', () async {
      final farm = FarmModel(
        id: idFarm,
        name: nameFarm,
      );
      final animal = AnimalModel(
        id: idFarm,
        farm: farm,
        tag: tagAnimal,
      );
      final farmAnimal = FarmAnimalsModel(
        id: idFarm,
        name: nameFarm,
        animals: [animal],
      );
      final listFarmAnimal = [
        farmAnimal,
      ];

      await farmViewModel.create(farmAnimal);
      expect(farmViewModel.value, equals(listFarmAnimal));
    });

    test('Test method update an item', () async {
      final farm = FarmModel(
        id: idFarm,
        name: nameFarm,
      );
      final animal = AnimalModel(
        id: idFarm,
        farm: farm,
        tag: tagAnimal,
      );
      final farmAnimal = FarmAnimalsModel(
        id: idFarm,
        name: nameFarm,
        animals: [animal],
      );

      await farmViewModel.create(farmAnimal);
      await farmViewModel.update(0, farmAnimal);
      expect(farmViewModel.value.first, equals(farmAnimal));
    });

    test('Test method delete all items', () async {
      final farm = FarmModel(
        id: idFarm,
        name: nameFarm,
      );
      final animal = AnimalModel(
        id: idFarm,
        farm: farm,
        tag: tagAnimal,
      );
      final farmAnimal = FarmAnimalsModel(
        id: idFarm,
        name: nameFarm,
        animals: [animal],
      );
      final listFarmAnimal = <FarmAnimalsModel>[];

      await farmViewModel.create(farmAnimal);
      await farmViewModel.deleteAll();
      expect(farmViewModel.value, equals(listFarmAnimal));
    });
  });
}

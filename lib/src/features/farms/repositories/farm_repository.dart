// Dart imports:
import 'dart:developer';

// Project imports:
import 'package:farmtrack/src/features/farms/models/farm_animals_model.dart';
import 'package:farmtrack/src/services/farm_service.dart';

class FarmRepository {
  final FarmService farmService;

  FarmRepository({
    required this.farmService,
  });

  Future<void> createFarmAnimal(FarmAnimalsModel farmAnimal) async {
    try {
      await farmService.addItem(farmAnimal);
      log('Farm animal added to box!');
    } catch (error) {
      throw Exception(error);
    }
  }

  List<FarmAnimalsModel> readAllFarmAnimals() {
    try {
      List<FarmAnimalsModel> result = [];
      for (var element in farmService.getAllItems()) {
        result.add(element);
      }
      return result;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> updateFarmAnimalAt(
      int index, FarmAnimalsModel farmAnimal) async {
    try {
      await farmService.updateItemAt(index, farmAnimal);
      log('Farm animal updated in box at index $index');
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> deleteFarmAnimalAt(int index) async {
    try {
      await farmService.deleteAt(index);
      log('Farm animal deleted from box at index: $index');
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> deleteAllFarmAnimals() async {
    try {
      await farmService.deleteAll();
      log('All farm animals was deleted from box!');
    } catch (error) {
      throw Exception(error);
    }
  }
}

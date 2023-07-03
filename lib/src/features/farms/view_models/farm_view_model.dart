// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:farmtrack/src/features/farms/models/farm_animals_model.dart';
import 'package:farmtrack/src/features/farms/repositories/farm_repository.dart';

class FarmViewModel extends ValueNotifier<List<FarmAnimalsModel>> {
  final FarmRepository farmRepository;

  FarmViewModel({
    required this.farmRepository,
  }) : super(farmRepository.readAllFarmAnimals());

  Future<void> create(FarmAnimalsModel farmAnimal) async {
    await farmRepository.createFarmAnimal(farmAnimal);
    read();
    notifyListeners();
  }

  void read() {
    value = farmRepository.readAllFarmAnimals();
    notifyListeners();
  }

  Future<void> update(int index, FarmAnimalsModel farmAnimal) async {
    await farmRepository.updateFarmAnimalAt(index, farmAnimal);
    read();
    notifyListeners();
  }

  Future<void> delete(int index) async {
    await farmRepository.deleteFarmAnimalAt(index);
    read();
    notifyListeners();
  }

  Future<void> deleteAll() async {
    await farmRepository.deleteAllFarmAnimals();
    read();
    notifyListeners();
  }
}

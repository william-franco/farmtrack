// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:farmtrack/src/features/farms/models/animal_model.dart';

part 'farm_animals_model.g.dart';

@HiveType(typeId: 3)
class FarmAnimalsModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<AnimalModel> animals;

  FarmAnimalsModel({
    required this.id,
    required this.name,
    required this.animals,
  });
}

// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:farmtrack/src/features/farms/models/farm_model.dart';

part 'animal_model.g.dart';

@HiveType(typeId: 2)
class AnimalModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final FarmModel farm;

  @HiveField(2)
  final String tag;

  AnimalModel({
    required this.id,
    required this.farm,
    required this.tag,
  });
}

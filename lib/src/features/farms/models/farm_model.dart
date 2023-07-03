// Package imports:
import 'package:hive/hive.dart';

part 'farm_model.g.dart';

@HiveType(typeId: 1)
class FarmModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  FarmModel({
    required this.id,
    required this.name,
  });
}

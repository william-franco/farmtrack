// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farm_animals_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FarmAnimalsModelAdapter extends TypeAdapter<FarmAnimalsModel> {
  @override
  final int typeId = 3;

  @override
  FarmAnimalsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FarmAnimalsModel(
      id: fields[0] as int,
      name: fields[1] as String,
      animals: (fields[2] as List).cast<AnimalModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, FarmAnimalsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.animals);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FarmAnimalsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

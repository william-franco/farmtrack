// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalModelAdapter extends TypeAdapter<AnimalModel> {
  @override
  final int typeId = 2;

  @override
  AnimalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnimalModel(
      id: fields[0] as int,
      farm: fields[1] as FarmModel,
      tag: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AnimalModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.farm)
      ..writeByte(2)
      ..write(obj.tag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

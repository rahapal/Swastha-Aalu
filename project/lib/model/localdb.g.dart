// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localdb.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailsAdapter extends TypeAdapter<Details> {
  @override
  final int typeId = 0;

  @override
  Details read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Details(
      image: fields[0] as String,
      disease: fields[1] as String,
      percentage: fields[2] as String,
      useremail: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Details obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.disease)
      ..writeByte(2)
      ..write(obj.percentage)
      ..writeByte(3)
      ..write(obj.useremail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

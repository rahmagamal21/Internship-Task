// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_repo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GitRepoAdapter extends TypeAdapter<GitRepo> {
  @override
  final int typeId = 0;

  @override
  GitRepo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GitRepo(
      name: fields[0] as String,
      description: fields[1] as String,
      ownerName: fields[2] as String,
      isForked: fields[3] as bool,
      repoLink: fields[4] as String,
      ownerLink: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GitRepo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.ownerName)
      ..writeByte(3)
      ..write(obj.isForked)
      ..writeByte(4)
      ..write(obj.repoLink)
      ..writeByte(5)
      ..write(obj.ownerLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GitRepoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

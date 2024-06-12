import 'package:hive/hive.dart';

part 'git_repo.g.dart';

@HiveType(typeId: 0)
class GitRepo {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String ownerName;
  @HiveField(3)
  final bool isForked;
  @HiveField(4)
  final String repoLink;
  @HiveField(5)
  final String ownerLink;

  GitRepo({
    required this.name,
    required this.description,
    required this.ownerName,
    required this.isForked,
    required this.repoLink,
    required this.ownerLink,
  });
}

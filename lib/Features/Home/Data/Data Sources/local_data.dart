import 'package:hive/hive.dart';
import 'package:task/Features/Home/Domain/entities/git_repo.dart';

class LocalData {
  final Box<GitRepo> repoBox;

  LocalData(this.repoBox);

  Future<void> cacheRepositories(List<GitRepo> repositories) async {
    await repoBox.clear();
    for (var repository in repositories) {
      await repoBox.put(repository.name, repository);
    }
  }

  Future<List<GitRepo>> getLastRepositories() async {
    return repoBox.values.toList();
  }
}

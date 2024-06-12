import 'package:task/Features/Home/Domain/entities/git_repo.dart';

class GitHubRepository extends GitRepo {
  GitHubRepository({
    required super.name,
    required super.description,
    required super.ownerName,
    required super.isForked,
    required super.repoLink,
    required super.ownerLink,
  });

  factory GitHubRepository.fromJson(Map<String, dynamic> json) {
    return GitHubRepository(
      name: json['name'],
      description: json['description'] ?? 'Not determined',
      ownerName: json['owner']['login'],
      isForked: json['fork'] ?? false,
      repoLink: json['html_url'],
      ownerLink: json['owner']['html_url'],
    );
  }
}

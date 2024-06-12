class GitHubRepository {
  GitHubRepository({
    required name,
    required description,
    required ownerName,
    required isForked,
    required repoLink,
    required ownerLink,
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

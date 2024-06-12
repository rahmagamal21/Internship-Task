import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task/Features/Home/Data/Data%20Model/repo_model.dart';

import '../../../../Core/error/error.dart';

abstract class RemoteData {
  static String apiUrl = 'https://api.github.com/users/square/repos';
  Future<List<GitHubRepository>> fetchRepositories() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((repo) => GitHubRepository.fromJson(repo)).toList();
    } else {
      throw throw ServerFailure('Failed to load repositories');
    }
  }
}

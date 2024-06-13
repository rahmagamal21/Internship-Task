import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../Data/Data Model/repo_model.dart';

part 'repos_request_state.dart';

class ReposRequestCubit extends Cubit<ReposRequestState> {
  static const int perPage = 10;
  int currentPage = 1;
  List<GitHubRepository> repositories = [];
  List<GitHubRepository> displayedRepositories = [];
  bool hasMore = true;

  ReposRequestCubit() : super(ReposRequestInitial());
  Future<void> fetchRepositories() async {
    try {
      emit(ReposRequestLoading());

      final box = await Hive.openBox<GitHubRepository>('repositories');
      final savedRepositories = box.values.toList();
      if (savedRepositories.isNotEmpty) {
        repositories = List.from(savedRepositories);
        displayedRepositories = List.from(savedRepositories);
        emit(
          ReposRequestSuccess(displayedRepositories),
        );
        return;
      }

      final response = await http.get(Uri.parse(
          'https://api.github.com/users/square/repos?page=$currentPage&per_page=$perPage'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final newRepositories =
            data.map((repo) => GitHubRepository.fromJson(repo)).toList();
        repositories.addAll(newRepositories);
        displayedRepositories = List.from(repositories);

        await box.clear();
        await box.addAll(repositories);
        emit(ReposRequestSuccess(displayedRepositories));
      } else {
        emit(ReposRequestFailure(
            'Failed to fetch repositories: ${response.statusCode}'));
      }
    } catch (error) {
      emit(ReposRequestFailure('Error fetching repositories: $error'));
    }
  }

  Future<void> fetchMoreRepositories() async {
    try {
      currentPage++;
      final response = await http.get(Uri.parse(
          'https://api.github.com/users/square/repos?page=$currentPage&per_page=$perPage'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final newRepositories =
            data.map((repo) => GitHubRepository.fromJson(repo)).toList();
        repositories.addAll(newRepositories); // Update the main list
        displayedRepositories = List.from(repositories);
        emit(ReposRequestMoreSuccess(displayedRepositories));
      } else {
        emit(ReposRequestFailure(
            'Failed to fetch more repositories: ${response.statusCode}'));
      }
    } catch (error) {
      emit(ReposRequestFailure('Error fetching more repositories: $error'));
    }
  }

  void filterRepositories(String searchText) {
    if (searchText.isNotEmpty) {
      final filteredList = repositories
          .where((repo) =>
              repo.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      displayedRepositories = List.from(filteredList);
      emit(ReposRequestSuccess(displayedRepositories));
    } else {
      displayedRepositories = List.from(repositories);
      emit(ReposRequestSuccess(displayedRepositories));
    }
  }

  Future<void> refreshRepositories() async {
    currentPage = 1;
    repositories.clear();
    displayedRepositories.clear();
    hasMore = true;
    await fetchRepositories();
  }
}

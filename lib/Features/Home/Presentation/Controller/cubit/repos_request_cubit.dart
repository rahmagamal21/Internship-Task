import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:task/Features/Home/Domain/entities/git_repo.dart';
import 'dart:convert';

import '../../../../../Core/error/error.dart';
import '../../../Data/Data Model/repo_model.dart';

part 'repos_request_state.dart';

class ReposRequestCubit extends Cubit<ReposRequestState> {
  ReposRequestCubit() : super(ReposRequestInitial());
  int _page = 1;
  final int _perPage = 10;
  bool _hasMore = true;
  List<GitRepo> _repositories = [];
  List<GitRepo> _filteredRepositories = [];
  bool get hasMore => _hasMore;
  List<GitRepo> get repositories => _repositories;
  List<GitRepo> get filteredRepositories => _filteredRepositories;
  Future<void> fetchRepositories() async {
    try {
      emit(ReposRequestLoading());

      final response = await http
          .get(Uri.parse('https://api.github.com/users/square/repos'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final repositories =
            data.map((repo) => GitHubRepository.fromJson(repo)).toList();
        emit(ReposRequestSuccess(repositories));
      } else {
        emit(ReposRequestFailure(
            'Failed to fetch repositories: ${response.statusCode}'));
      }
    } catch (error) {
      emit(ReposRequestFailure('Error fetching repositories: $error'));
    }
  }

  Future<void> loadRepositories() async {
    if (state is ReposRequestLoading) return;
    emit(ReposRequestLoading(_repositories, _hasMore));

    final Either<Failure, List<GitRepo>> result =
        await fetchRepositories.call(Params(page: _page, perPage: _perPage));

    result.fold(
      (failure) => emit(RepositoryError(
          message: _mapFailureToMessage(failure), repositories: _repositories)),
      (repositories) {
        _repositories.addAll(repositories);
        _filteredRepositories = List.from(_repositories);
        _page++;
        _hasMore = repositories.length == _perPage;
        emit(RepositoryLoaded(
            repositories: _filteredRepositories, hasMore: _hasMore));
      },
    );
  }

  Future<void> refreshRepositories() async {
    _page = 1;
    _repositories.clear();
    _filteredRepositories.clear();
    _hasMore = true;
    await loadRepositories();
  }

  void filterRepositories(String query) {
    if (query.isEmpty) {
      _filteredRepositories = List.from(_repositories);
    } else {
      _filteredRepositories = _repositories
          .where(
              (repo) => repo.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    emit(RepositoryLoaded(
        repositories: _filteredRepositories, hasMore: _hasMore));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return 'Server Failure';
      case const (CacheFailure):
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}

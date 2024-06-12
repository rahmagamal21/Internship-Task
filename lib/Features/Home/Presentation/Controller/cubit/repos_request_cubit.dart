import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../Data/Data Model/repo_model.dart';

part 'repos_request_state.dart';

class ReposRequestCubit extends Cubit<ReposRequestState> {
  ReposRequestCubit() : super(ReposRequestInitial());
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
}

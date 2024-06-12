part of 'repos_request_cubit.dart';

sealed class ReposRequestState {}

final class ReposRequestInitial extends ReposRequestState {}

final class ReposRequestLoading extends ReposRequestState {}

final class ReposRequestSuccess extends ReposRequestState {}

final class ReposRequestFailure extends ReposRequestState {
  final String errorMessage;

  ReposRequestFailure(this.errorMessage);
}

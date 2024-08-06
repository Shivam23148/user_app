part of 'user_list_bloc.dart';

abstract class UserListState {}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<User> usersData;

  UserListLoaded({required this.usersData});
}

class UserListError extends UserListState {
  final String error;

  UserListError({required this.error});
}

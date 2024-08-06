part of 'user_list_bloc.dart';

abstract class UserListEvent {}

class UserFetchEvent extends UserListEvent {}

class UserDetailFetchEvent extends UserListEvent {
  int id;
  UserDetailFetchEvent({
    required this.id,
  });
}

class UserSearchListEvent extends UserListEvent {
  final String querry;

  UserSearchListEvent({required this.querry});
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:user_app/data/models/user_model.dart';
import 'package:user_app/data/repository/user_repository.dart';
import 'package:user_app/network/api_service.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserRepository userRepository = UserRepository(ApiService(Dio()));
  List<User> allUsers = [];
  List<User> searchList = [];

  UserListBloc() : super(UserListInitial()) {
    on<UserFetchEvent>((event, emit) async {
      emit(UserListLoading());
      try {
        final users = await userRepository.fetchUsers();
        allUsers = users;
        emit(UserListLoaded(usersData: users));
      } catch (e) {
        emit(UserListError(error: e.toString()));
      }
    });

    on<UserSearchListEvent>((event, emit) async {
      if (event.querry.isEmpty) {
        emit(UserListLoaded(usersData: allUsers));
      } else {
        searchList = allUsers
            .where((user) =>
                user.name!.toLowerCase().contains(event.querry.toLowerCase()))
            .toList();
        emit(UserListLoaded(usersData: searchList));
      }
    });
  }
}

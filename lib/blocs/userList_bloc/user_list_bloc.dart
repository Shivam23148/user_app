import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:user_app/data/models/user_model.dart';
import 'package:user_app/data/repository/user_repository.dart';
import 'package:user_app/network/api_service.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserRepository userRepository = UserRepository(ApiService(Dio()));
  UserListBloc() : super(UserListInitial()) {
    on<UserFetchEvent>((event, emit) async {
      emit(UserListLoading());
      try {
        final user = await userRepository.fetchUsers();
        emit(UserListLoaded(usersData: user));
      } catch (e) {
        emit(UserListError(error: e.toString()));
      }
    });
    on<UserDetailFetchEvent>((event, emit) async {
      emit(UserListLoading());
      try {
        final userData = await userRepository.fetchUserDetail(event.id);
        print("User Data is: ${userData}");
        // emit(UserDetailsLoaded(userData: userData));
      } catch (e) {
        emit(UserListError(error: e.toString()));
      }
    });
  }
}

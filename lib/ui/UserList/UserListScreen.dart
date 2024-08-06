import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/blocs/userList_bloc/user_list_bloc.dart';
import 'package:user_app/data/models/user_model.dart';
import 'package:user_app/data/repository/user_repository.dart';
import 'package:user_app/network/api_service.dart';
import 'package:user_app/ui/UserDetail/UserDetailScreen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late UserListBloc userListBloc;

  @override
  void initState() {
    super.initState();
    userListBloc = UserListBloc();
    userListBloc.add(UserFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            userListBloc.add(UserFetchEvent());
            return Future<void>.delayed(const Duration(seconds: 1));
          },
          child: BlocBuilder<UserListBloc, UserListState>(
            bloc: userListBloc,
            builder: (context, state) {
              if (state is UserListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserListLoaded) {
                return ListView.builder(
                    itemCount: state.usersData.length,
                    itemBuilder: (context, index) {
                      final userData = state.usersData[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(userData.name![0]),
                        ),
                        title: Text(userData.name ?? "No Name"),
                        subtitle: Text(userData.username ?? "No Username"),
                        onTap: () {
                          /* userListBloc
                              .add(UserDetailFetchEvent(id: userData.id ?? 0)); */
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDetailScreen(
                                        user: userData,
                                      )));
                        },
                      );
                    });
              } else if (state is UserListError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/error.png"),
                    Text(state.error)
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}

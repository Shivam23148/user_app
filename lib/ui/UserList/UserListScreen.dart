import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/blocs/userList_bloc/user_list_bloc.dart';
import 'package:user_app/data/models/user_model.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'User List',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: RefreshIndicator(
        color: Colors.black,
        backgroundColor: Colors.white,
        onRefresh: () {
          userListBloc.add(UserFetchEvent());
          return Future<void>.delayed(const Duration(seconds: 1));
        },
        child: BlocBuilder<UserListBloc, UserListState>(
          bloc: userListBloc,
          builder: (context, state) {
            if (state is UserListLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else if (state is UserListLoaded) {
              return Column(
                children: [
                  searchBar(),
                  userListContainer(state),
                ],
              );
            } else if (state is UserListError) {
              return errorScreen(state);
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedSearchBar(
        animationDuration: Duration(seconds: 5),
        label: "Search by name",
        labelStyle: const TextStyle(fontSize: 18),
        onChanged: (value) {
          userListBloc.add(UserSearchListEvent(querry: value));
        },
        searchDecoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: const TextStyle(color: Colors.black54),
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
      ),
    );
  }

  Widget userListContainer(UserListLoaded state) {
    return Expanded(
      child: state.usersData.isNotEmpty
          ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.usersData.length,
              itemBuilder: (context, index) {
                final userData = state.usersData[index];
                return userListItem(userData, index);
              },
            )
          : const Center(
              child: Text("No Data Found"),
            ),
    );
  }

  Widget userListItem(User userData, int index) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade100,
          child: Text(
            userData.name![0],
          ),
        ),
        title: Text(userData.name ?? "No Name"),
        subtitle: Text(userData.username ?? "No Username"),
        trailing: const Icon(Icons.person),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailScreen(user: userData),
            ),
          );
        },
      ),
    );
  }

  Widget errorScreen(UserListError state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/error.png"),
        const SizedBox(height: 20),
        Text(
          state.error,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, color: Colors.redAccent),
        ),
      ],
    );
  }
}

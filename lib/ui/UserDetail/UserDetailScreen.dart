// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:user_app/data/models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  User user;
  UserDetailScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name ?? "No Name"),
      ),
      body: Column(),
    );
  }
}

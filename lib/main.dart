import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/blocs/internetConnectivity_bloc/internet_connectivity_bloc.dart';
import 'package:user_app/ui/InternetDisconnected/InternetDisconnected_Screen.dart';
import 'package:user_app/ui/Splash/SplashScreen.dart';
import 'package:user_app/ui/UserList/UserListScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetConnectivityBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<InternetConnectivityBloc, InternetConnectivityState>(
          builder: (context, state) {
            if (state is InternetDisconnected) {
              return InternetdisconnectedScreen();
            } else {
              return UserListScreen();
            }
          },
        ),
      ),
    );
  }
}

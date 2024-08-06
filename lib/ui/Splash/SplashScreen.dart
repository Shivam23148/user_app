import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/blocs/internetConnectivity_bloc/internet_connectivity_bloc.dart';
import 'package:user_app/ui/InternetDisconnected/InternetDisconnected_Screen.dart';
import 'package:user_app/ui/UserList/UserListScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserListScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<InternetConnectivityBloc, InternetConnectivityState>(
        listener: (context, state) {
          if (state is InternetConnected) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => UserListScreen()),
            );
          } else if (state is InternetDisconnected) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => InternetdisconnectedScreen()),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/UserLogo.png',
                height: MediaQuery.sizeOf(context).height * 0.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

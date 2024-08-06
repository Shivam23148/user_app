import 'package:flutter/material.dart';

class InternetdisconnectedScreen extends StatelessWidget {
  const InternetdisconnectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/nointernet.png",
              height: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "No Internet",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

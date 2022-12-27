import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);
  static const String routeName = '/ErrorScreen';

  static getNavigator() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: "/ErrorScreen"),
        builder: (c) {
          return const ErrorScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Error"),
      ),
    );
  }
}

import 'package:clone_radish_app/states/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈 스크린'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<UserProvider>().setUserAuth(false);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}

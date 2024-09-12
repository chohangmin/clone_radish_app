import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈 스크린'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}

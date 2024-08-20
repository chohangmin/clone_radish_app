import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: PageView(children: [
        const Center(child: Text('로그인을 하시오')),
        Container(
          color: Colors.accents[2],
        ),
        Container(
          color: Colors.accents[5],
        )
      ]),
    );
  }
}

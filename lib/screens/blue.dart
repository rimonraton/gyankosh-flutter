import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:crypt/crypt.dart';

class Blue extends StatelessWidget {
  const Blue({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blue ScreenG'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Flutter DeepLinking tutorialG! $id'),
            MaterialButton(
              onPressed: () => context.go('/'),
              color: Colors.red,
              child: const Text('Homes'),
            ),
            MaterialButton(
              onPressed: () => printEncrypt(),
              color: Colors.white,
              child: const Text('Encrypt'),
            ),
            MaterialButton(
              onPressed: () => context.go('/red'),
              color: Colors.red,
              child: const Text('Red'),
            ),

          ],
        ),
      ),
      backgroundColor: Colors.green,
    );
  }

  void printEncrypt() {
    final pass = Crypt.sha256('12345678');
    print('Encrypted Password => $pass');
  }
}

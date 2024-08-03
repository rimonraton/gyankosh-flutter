import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Red extends StatelessWidget {
  const Red({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Red Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Flutter DeepLinking tutorial! '),
            MaterialButton(
              onPressed: () => context.go('/'),
              color: Colors.blue,
              child: const Text('Home'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.red,
    );
  }
}

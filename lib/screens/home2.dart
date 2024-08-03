import 'package:gyankosh/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'gyankosh.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Flutter DeepLinking tutorial!'),
            MaterialButton(
              // onPressed: () => context.go('/blue/123'),
              onPressed: () => context.go('/blue/123'),
              color: Colors.blue,
              child: const Text('Blue Screen with 123'),
            ),
            MaterialButton(
              onPressed: () => context.go('/signIn'),
              color: Colors.red,
              child: const Text('Sign In Screen'),
            ),
            MaterialButton(
              onPressed: () => context.go('/signUp'),
              color: Colors.red,
              child: const Text('Sign Up Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/background.jpg",
              fit: BoxFit.fill,
            ),
          ),
          (_loginStatus == 1) ? const Gyankosh() : const SignIn()
          // const SignIn()
        ],
      ),
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
    );
  }

  var _loginStatus = 0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _loginStatus = preferences.getInt("login")!;
    });
  }
}

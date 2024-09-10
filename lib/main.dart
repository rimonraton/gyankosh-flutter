import 'package:gyankosh/screens/blue.dart';
import 'package:gyankosh/screens/challenge.dart';
import 'package:gyankosh/screens/gyankosh.dart';
import 'package:gyankosh/screens/red.dart';
import 'package:gyankosh/screens/reset_password.dart';
import 'package:gyankosh/screens/signin.dart';
import 'package:gyankosh/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:gyankosh/screens/home.dart';
import 'package:go_router/go_router.dart';
import 'package:gyankosh/screens/update_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  getLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt("login")!;
  }

  final goRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const Gyankosh(),
      ),

      GoRoute(
        path: '/blue/:id',
        builder: (context, GoRouterState state) {
          final id = state.pathParameters['id']!;
          debugPrint('Blue id $id');
          return Blue(id: id);
        },
      ),
      GoRoute(
        path: '/red',
        builder: (context, GoRouterState state) {
          return const Red();
        },
      ),
      GoRoute(
        path: '/:game/:gid/:uid/share',
        builder: (context, GoRouterState state) {
          final url = state.uri;
          return Challenge(url: url);
        },
      ),
      GoRoute(
        path: '/:game/:gid/:uid',
        builder: (context, GoRouterState state) {
          final url = state.uri;
          return Challenge(url: url);
        },
      ),
      GoRoute(
        path: '/signIn',
        builder: (context, state) => const SignIn(),
      ),
      GoRoute(
        path: '/signUp',
        builder: (context, state) => const SignUp(),
      ),
      GoRoute(
        path: '/resetPassword',
        builder: (context, state) => const ResetPassword(),
      ),
      GoRoute(
        path: '/updatePassword',
        builder: (context, state) => const UpdatePassword(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}

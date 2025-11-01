import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthFunc extends StatelessWidget {
  final bool loggedIn;
  final VoidCallback signOut;

  const AuthFunc({required this.loggedIn, required this.signOut, super.key});

  @override
  Widget build(BuildContext context) {
    return loggedIn
        ? ElevatedButton(onPressed: signOut, child: const Text('Sign Out'))
        : ElevatedButton(
            onPressed: () {
              context.push('/sign-in'); // use GoRouter's context.push
            },
            child: const Text('Sign In'),
          );
  }
}

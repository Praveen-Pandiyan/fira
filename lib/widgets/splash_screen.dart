import 'package:fira/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Expanded(
            flex: 3,
            child: Center(
              child: Text(
                "Fira",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 45,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: BlocBuilder<AuthenticationBloc, AuthState>(
                builder: (context, state) {
                  if (state == AuthState.loggedOut) {
                    return TextButton(
                        onPressed: () {
                          context
                              .read<AuthenticationBloc>()
                              .add(AuthEvent.login);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                            ((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color.fromARGB(255, 26, 117, 192);
                              }
                              return Colors.blue;
                            }),
                          ),
                        ),
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white),
                        ));
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

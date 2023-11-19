import 'package:fira/bloc/auth/auth_bloc.dart';
import 'package:fira/bloc/tickets/tickets_bloc.dart';
import 'package:fira/firebase_options.dart';
import 'package:fira/services/auth_services.dart';
import 'package:fira/services/ticket_services.dart';
import 'package:fira/widgets/home_page/home_page.dart';
import 'package:fira/widgets/splash_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var firebaseAppCheck = FirebaseAppCheck.instance;
  firebaseAppCheck.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.playIntegrity,

  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _authService = FiraAuthService();
  final _ticketService = TicketsServices();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (BuildContext context) =>
                  AuthenticationBloc(_authService),
            ),
            BlocProvider<TicketListBloc>(
              create: (BuildContext context) => TicketListBloc(_ticketService),
            ),
          ],
          child: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthState>(
      builder: (context, state) {
        if (state == AuthState.loggedIn) {
          return const HomePage();
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}

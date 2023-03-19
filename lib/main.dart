import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glaengage/splash.dart';
import 'package:provider/provider.dart';
import 'backend/auth.dart';
import 'backend/keywords.dart';
import 'backend/models.dart';
import 'backend/providers.dart';
import 'firebase_options.dart';
import 'root/pages/auth/login.dart';
import 'root/pages/auth/signup.dart';
import 'root/pages/main_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final token = await FirebaseMessaging.instance.getToken();
  log(token!);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 150,
              right: 150,
            )),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.indigo),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeNavigator();
        } else {
          return const AuthPage();
        }
      },
    );
  }
}

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({super.key});

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  String? userType;

  getData() async {
    ProfileModel? data = await Auth.getProfileByMail(
        FirebaseAuth.instance.currentUser!.email ?? "");
    if (mounted) {
      if (context.mounted) {
        if (data == null) {
          FirebaseAuth.instance.signOut();
        } else {
          if (data.type == KeyWords.studentUser) {
            context.read<UserProvider>().setUserType(KeyWords.studentUser);
            context
                .read<UserProvider>()
                .setStudent(StudentModel.fromMap(data.toMap()));
          } else if (data.type == KeyWords.alumniUser) {
            context.read<UserProvider>().setUserType(KeyWords.alumniUser);
            context
                .read<UserProvider>()
                .setAlumni(AlumniModel.fromMap(data.toMap()));
          } else if (data.type == KeyWords.teacherUser) {
            context.read<UserProvider>().setUserType(KeyWords.teacherUser);
            context
                .read<UserProvider>()
                .setTeacher(TeacherModel.fromMap(data.toMap()));
          }
          setState(() {
            userType = data.type;
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userType == null) {
      return const SplashScreen();
    } else {
      return const NavBarView();
    }
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  bool showSignIn = true;

  togglePages() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInPage(
        togglePages: togglePages,
      );
    } else {
      return SignUpWelcome(
        togglePages: togglePages,
      );
    }
  }
}

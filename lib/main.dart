import 'dart:async';
import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_provider/app/service_locator.dart';

import 'counter_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //Application logic/other runtime errors
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      setUpServiceLocator();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      //Flutter framework error
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      //Async errors of flutter framework
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      runApp(MyApp());
    },
    (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(create: (_) => CounterCubit()),
        BlocProvider<CounterBloc>(create: (_) => CounterBloc()),
      ],
      child: const MaterialApp(title: 'Flutter Demo', home: HomeScreen()),
    );
  }

  void doSomething() {}
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isEnable = false; // local/widget/Ephemeral

  @override
  void initState() {
    super.initState();
    FirebaseCrashlytics.instance.setUserIdentifier('rafat_meraz');
    FirebaseCrashlytics.instance.setCustomKey('user_id', 'rafat_meraz');
    FirebaseCrashlytics.instance.log("Entered Homescreen");
    FirebaseAnalytics.instance.setUserProperty(
      name: 'user_id',
      value: 'sdfjsalfjlsaf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Dark Mode'),
                  Switch(
                    value: isEnable,
                    onChanged: (bool value) {
                      FirebaseAnalytics.instance.logEvent(
                        name: "theme_changed",
                        parameters: {
                          'previous_value': "$isEnable",
                          'new_value': '$value',
                        },
                      );
                      isEnable = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<CounterBloc, int>(
              builder: (context, value) {
                return Text('$value');
              },
            ),
            TextButton(
              onPressed: () {
                FirebaseCrashlytics.instance.log(
                  "Pressed go to profile button",
                );
                throw Exception("Amar iccha hoise tai dilam");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: const Text('Go to profile'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterBloc>().add(IncrementEvent());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Type of state - Ephemeral, App state

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<CounterBloc, int>(
        builder: (context, int count) {
          return Center(child: Text('$count'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterBloc>().add(DecrementEvent());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key, required this.count, required this.updateCount});

  int count;
  final VoidCallback updateCount;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(child: Text('${widget.count}')),
    );
  }
}

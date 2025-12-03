import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_provider/app/service_locator.dart';

import 'counter_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  runApp(MyApp());
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

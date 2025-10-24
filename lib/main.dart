import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_provider/app/set_up_dio.dart';
import 'package:state_management_provider/core/network_executor/error_mapper/default_error_mapper.dart';
import 'package:state_management_provider/core/network_executor/models/request_model.dart';
import 'package:state_management_provider/core/network_executor/network_executor.dart';

Dio dio = getDioInstance();
NetworkExecutor networkExecutor = NetworkExecutor(
  dio: dio,
  errorMapper: DefaultErrorMapper(
    onUnauthorize: () {
      //if user already in login page
      //logout from app
    },
  ),
);

void main() {
  runApp(ChangeNotifierProvider(create: (_) => CounterModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

//HomeScreen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    networkExecutor.getRequest(RequestModel(path: 'sfdasfsa'));
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Counter App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.mobile_friendly),
            tooltip: "Mobile",
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer<CounterModel>(
              builder: (context, value, child) {
                return Text("Counter value ->> ${value._count}");
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    context.read<CounterModel>().increment();
                  },
                  child: Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () {
                    context.read<CounterModel>().decrement();
                  },
                  child: Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//CounterModel
class CounterModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    if (_count > 0) {
      _count--;
      notifyListeners();
    }
  }
}

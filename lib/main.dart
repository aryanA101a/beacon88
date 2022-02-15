import 'package:beacon/locator.dart';
import 'package:beacon/view_model/beacons_fragment_view_model.dart';
import 'package:beacon/view_model/home_screen_view_model.dart';
import 'package:beacon/views/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt<HomeScreenViewModel>(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => BeaconsFragmentViewModel(),
        // )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

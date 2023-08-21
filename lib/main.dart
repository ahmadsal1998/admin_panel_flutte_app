import 'package:admin_panel/constants/theme.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:admin_panel/screens/home_page/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'helpers/firebase_options/firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Admin Panel',
        theme: themeData,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );


  }
}


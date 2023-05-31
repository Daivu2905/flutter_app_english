import 'package:flutter/material.dart';
import 'package:flutter_app_new_demo/packages/quote/quote.dart';
import 'package:flutter_app_new_demo/page/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Quotes().getAll();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LandingPage(),

      // child: Image.asset('assets/images/right_arrow.png'),
    );
  }
}

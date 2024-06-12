import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'Features/Home/Presentation/Views/home_view.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('repoCache');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}

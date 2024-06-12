import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task/Features/Home/Presentation/Controller/cubit/repos_request_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ReposRequestCubit()..fetchRepositories(),
        child: const HomeView(),
      ),
    );
  }
}

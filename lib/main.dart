import 'package:a3data_challenge/src/app/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import './src/app/config/dependencies_injection.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependenciesInjection.registerDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.paths,
    );
  }
}

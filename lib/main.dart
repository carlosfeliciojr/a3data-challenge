import 'package:a3data_challenge/src/app/module/repositories/list_repositories/controller/repositories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import './src/app/config/dependencies_injection.dart';
import 'src/app/module/repositories/list_repositories/view/list_repositories_view.dart';

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
      home: ListRepositoriesView(
        controller: getIt.get<RepositoriesController>(),
      ),
    );
  }
}

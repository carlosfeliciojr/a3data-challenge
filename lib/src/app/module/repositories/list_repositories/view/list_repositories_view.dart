import 'package:a3data_challenge/src/app/module/repositories/list_repositories/controller/repositories_controller.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/widgets/favorites_repositories_widget.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/widgets/repository_card_widget.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/widgets/search_user_widget.dart';
import 'package:a3data_challenge/src/shared/wigets/github_icon_widget.dart';
import 'package:flutter/material.dart';

class ListRepositoriesView extends StatefulWidget {
  const ListRepositoriesView({super.key, required this.controller});

  final RepositoriesController controller;

  @override
  State<ListRepositoriesView> createState() => _ListRepositoriesViewState();
}

class _ListRepositoriesViewState extends State<ListRepositoriesView> {
  late RepositoriesController controller;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D1017),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff0D1017),
        leading: const GithubIconWidget(),
        centerTitle: true,
        title: SearchUserWidget(
          onPressed: () {},
        ),
        actions: [
          FavoritesRepositoriesWidget(
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder(
          future: controller.getRepositories(),
          initialData: controller.repositories.listOfRepositories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: controller.repositories.lenght,
                itemBuilder: (context, index) {
                  final lastIndex = controller.repositories.lenght - 1;
                  final repository =
                      controller.repositories.listOfRepositories[index];
                  return RepositoryCardWidget(
                    key: ValueKey(index),
                    index: index,
                    lastIndex: lastIndex,
                    name: repository.name,
                    description: repository.description,
                    language: repository.language,
                    creationDate: repository.creationDate,
                    watchers: repository.watchers,
                  );
                },
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            return const Center(child: Text("Sem repositórios"));
          },
        ),
      ),
    );
  }
}

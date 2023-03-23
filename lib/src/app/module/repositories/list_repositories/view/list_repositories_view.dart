import 'package:a3data_challenge/src/app/config/routes.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/controller/repositories_controller.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/widgets/favorites_repositories_widget.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/widgets/public_card_widget.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/widgets/search_user_widget.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/widgets/whitout_data_widget.dart';
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
        centerTitle: true,
        title: SearchUserWidget(
          onSearch: controller.getUserRepositories,
          onChanged: controller.onInputUserName,
        ),
        actions: [
          AnimatedBuilder(
            animation: controller.favoritesRepositories,
            builder: (context, snapshot) {
              return FavoritesRepositoriesWidget(
                count: controller.favoritesRepositories.lenght,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(Routes.listFavoritesRepositories);
                },
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder(
          future: controller.getRepositories(),
          initialData: controller.publicRepositories.list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AnimatedBuilder(
                animation: controller,
                builder: (context, widget) {
                  if (controller.publicRepositories.isEmpty) {
                    return const WhitoutDataWidget();
                  }
                  return ListView.builder(
                    itemCount: controller.publicRepositories.lenght,
                    itemBuilder: (context, index) {
                      final lastIndex =
                          controller.publicRepositories.lenght - 1;
                      final repository =
                          controller.publicRepositories.list[index];
                      return PublicCardWidget(
                        key: ValueKey(repository.id),
                        id: repository.id,
                        index: index,
                        lastIndex: lastIndex,
                        name: repository.name,
                        description:
                            repository.description ?? 'Without description',
                        language: repository.language,
                        creationDate: repository.creationDate,
                        watchers: repository.watchers,
                        isFavorite: repository.isFavorite,
                        onPressed: controller.addReporitoryToFavorites,
                      );
                    },
                  );
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

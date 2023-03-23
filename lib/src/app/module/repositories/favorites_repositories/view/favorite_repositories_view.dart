import 'package:a3data_challenge/src/app/module/repositories/favorites_repositories/controller/favorites_repositories_controller.dart';
import 'package:a3data_challenge/src/app/module/repositories/favorites_repositories/widgets/favorite_card_widget.dart';
import 'package:a3data_challenge/src/app/module/repositories/list_repositories/widgets/whitout_data_widget.dart';
import 'package:flutter/material.dart';

class FavoritesRepositoriesView extends StatefulWidget {
  const FavoritesRepositoriesView({super.key, required this.controller});

  final FavoritesRepositoriesController controller;

  @override
  State<FavoritesRepositoriesView> createState() =>
      _ListRepositoriesViewState();
}

class _ListRepositoriesViewState extends State<FavoritesRepositoriesView> {
  late FavoritesRepositoriesController controller;

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
        title: const Text("Favorites"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder(
          future: controller.getFavoritesRepositories(),
          initialData: controller.favoritesRepositories.list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AnimatedBuilder(
                animation: controller,
                builder: (context, widget) {
                  if (controller.favoritesRepositories.isEmpty) {
                    return const WhitoutDataWidget();
                  }
                  return ListView.builder(
                    itemCount: controller.favoritesRepositories.lenght,
                    itemBuilder: (context, index) {
                      final lastIndex =
                          controller.favoritesRepositories.lenght - 1;
                      final repository =
                          controller.favoritesRepositories.list[index];
                      return FavoriteCardWidget(
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
                        onPressed: controller.removeFavorite,
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

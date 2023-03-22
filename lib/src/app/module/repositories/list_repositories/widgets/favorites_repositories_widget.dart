// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:a3data_challenge/src/app/module/repositories/list_repositories/widgets/counter_favorites_widget.dart';

class FavoritesRepositoriesWidget extends StatelessWidget {
  const FavoritesRepositoriesWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.bookmark),
            color: const Color(0xffC9D1D9),
            padding: const EdgeInsets.only(right: 6),
            splashRadius: 16,
            constraints: const BoxConstraints(maxWidth: 32),
          ),
          const CounterFavoritesWidget(),
        ],
      ),
    );
  }
}

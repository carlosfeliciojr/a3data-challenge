import 'package:a3data_challenge/src/app/module/repositories/favorites_repositories/models/favorite_repository_model.dart';
import 'package:a3data_challenge/src/domain/entities/language_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FavoriteCardWidget extends StatefulWidget {
  const FavoriteCardWidget({
    super.key,
    required this.id,
    required this.index,
    required this.name,
    required this.description,
    required this.creationDate,
    required this.language,
    required this.watchers,
    required this.lastIndex,
    required this.isFavorite,
    required this.onPressed,
  });

  final String id;
  final String name;
  final String description;
  final DateTime creationDate;
  final LanguageEntity language;
  final int watchers;
  final int index;
  final int lastIndex;
  final bool isFavorite;
  final Future<void> Function({required FavoriteRepositoryModel unfavored})
      onPressed;

  @override
  State<FavoriteCardWidget> createState() => _RepositoryCardWidgetState();
}

class _RepositoryCardWidgetState extends State<FavoriteCardWidget>
    with TickerProviderStateMixin {
  EdgeInsets cardPadding() {
    if (widget.index == 0) {
      return const EdgeInsets.only(top: 24, bottom: 2);
    }

    if (widget.index == widget.lastIndex) {
      return const EdgeInsets.only(top: 2, bottom: 32);
    }

    return const EdgeInsets.only(top: 4, bottom: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: cardPadding(),
      child: Stack(
        children: [
          Material(
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: const Color(0xff161B21),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              widget.name,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Color(0xff58A5FF),
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffC9D1D9),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: BoxDecoration(
                                          color: widget.language.color,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(4),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      SizedBox(
                                        width: 56,
                                        child: Text(
                                          widget.language.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: widget.language.color,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_border_outlined,
                                        color: Color(0xffC9D1D9),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      SizedBox(
                                        width: 56,
                                        child: Text(
                                          widget.watchers.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xffC9D1D9),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.date_range,
                                        color: Color(0xffC9D1D9),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        DateFormat('yy/MM/dd')
                                            .format(
                                                widget.creationDate.toLocal())
                                            .toString(),
                                        style: const TextStyle(
                                          color: Color(0xffC9D1D9),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!widget.isFavorite)
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Color(0xffDA3633),
                        ),
                        elevation: MaterialStatePropertyAll(0),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      onPressed: () async => widget.onPressed(
                        unfavored: FavoriteRepositoryModel(
                          id: widget.id,
                          name: widget.name,
                          description: widget.description,
                          creationDate: widget.creationDate,
                          language: widget.language,
                          watchers: widget.watchers,
                          isFavorite: widget.isFavorite,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 0,
                        ),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.bookmark_add_outlined,
                              color: Color(0xffC9D1D9),
                              size: 28,
                            ),
                            Text(
                              "Remove\nRepo",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xffC9D1D9),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

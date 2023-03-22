import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';
import 'package:flutter/material.dart';

class RepositoryCardWidget extends StatefulWidget {
  const RepositoryCardWidget({
    super.key,
    required this.index,
    required this.name,
    required this.description,
    required this.creationDate,
    required this.language,
    required this.watchers,
    required this.lastIndex,
  });

  final String name;
  final String description;
  final DateTime creationDate;
  final CodeLanguageEnum language;
  final int watchers;
  final int index;
  final int lastIndex;

  @override
  State<RepositoryCardWidget> createState() => _RepositoryCardWidgetState();
}

class _RepositoryCardWidgetState extends State<RepositoryCardWidget>
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
                                        decoration: const BoxDecoration(
                                          color: Color(0xff27B4AB),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        widget.language.text,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff27B4AB)),
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
                                      Text(
                                        widget.watchers.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffC9D1D9),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color(0xff58A5FF),
                      ),
                      elevation: MaterialStatePropertyAll(0),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.bookmark_add_outlined,
                            color: Color(0xffC9D1D9),
                            size: 28,
                          ),
                          Text(
                            "Save\nRepo",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffC9D1D9),
                              fontWeight: FontWeight.w500,
                            ),
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

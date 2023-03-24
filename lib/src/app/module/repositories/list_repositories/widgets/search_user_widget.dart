import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchUserWidget extends StatefulWidget {
  const SearchUserWidget({
    super.key,
    required this.onSearch,
    required this.onChanged,
  });

  final Future<void> Function({
    required BuildContext context,
    required String username,
  }) onSearch;
  final void Function(String) onChanged;

  @override
  State<SearchUserWidget> createState() => _SearchUserWidgetState();
}

class _SearchUserWidgetState extends State<SearchUserWidget> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 84,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 192 + 32),
          child: CupertinoTextField(
            controller: _textController,
            enableSuggestions: true,
            decoration: const BoxDecoration(
              color: Color(0xff161B21),
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            onChanged: widget.onChanged,
            style: const TextStyle(color: Color(0xffC9D1D9)),
            maxLength: 39,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            maxLines: 1,
            placeholder: "Input GitHub user name...",
            placeholderStyle: const TextStyle(color: Color(0xffC9D1D9)),
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
          onPressed: () async {
            widget.onSearch(context: context, username: _textController.text);
          },
          icon: const Icon(Icons.search, color: Color(0xffC9D1D9)),
          constraints: const BoxConstraints(maxWidth: 24, maxHeight: 24),
          padding: const EdgeInsets.all(0),
          splashRadius: 16,
        )
      ],
    );
  }
}

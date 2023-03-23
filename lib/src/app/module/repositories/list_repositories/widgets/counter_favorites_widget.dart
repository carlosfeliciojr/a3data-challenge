import 'package:flutter/material.dart';

class CounterFavoritesWidget extends StatelessWidget {
  const CounterFavoritesWidget({
    super.key,
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    if (count > 0) {
      return Positioned(
        top: 8,
        left: 12,
        child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: const Color(0xffF78166),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Center(
            child: Text(
              count > 9 ? "+9" : count.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

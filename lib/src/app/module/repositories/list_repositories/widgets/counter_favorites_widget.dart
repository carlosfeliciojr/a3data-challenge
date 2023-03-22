import 'package:flutter/material.dart';

class CounterFavoritesWidget extends StatelessWidget {
  const CounterFavoritesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        child: const Center(
            child: Text(
          "+9",
          style: TextStyle(fontSize: 12),
        )),
      ),
    );
  }
}

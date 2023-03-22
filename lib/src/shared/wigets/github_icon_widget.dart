import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GithubIconWidget extends StatelessWidget {
  const GithubIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: SvgPicture.asset(
        "assets/svg/github-tile.svg",
        semanticsLabel: "GitHub Logo",
        fit: BoxFit.cover,
      ),
    );
  }
}

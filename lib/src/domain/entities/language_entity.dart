// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LanguageEntity {
  LanguageEntity({
    required this.name,
    this.color = const Color(0xffC9D1D9),
  });

  String name;
  Color color;
}

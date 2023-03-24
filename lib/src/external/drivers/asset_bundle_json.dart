import 'dart:convert';

import 'package:a3data_challenge/src/infra/drivers/asset_json.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class AssetBundleJson extends AssetJson {
  AssetBundleJson({required this.assetBundle});

  final AssetBundle assetBundle;

  @override
  Future<dynamic> getItem({required String path}) async {
    String data = await assetBundle.loadString(path);
    final map = jsonDecode(data);
    return map;
  }
}

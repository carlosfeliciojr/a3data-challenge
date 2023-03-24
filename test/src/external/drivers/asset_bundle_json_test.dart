import 'package:a3data_challenge/src/external/drivers/asset_bundle_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'asset_bundle_json_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AssetBundle>(
    onMissingStub: OnMissingStub.returnDefault,
  )
])
void main() {
  final AssetBundle mockDefaultAssetBundle = MockAssetBundle();
  final AssetBundleJson assetBundleJson = AssetBundleJson(
    assetBundle: mockDefaultAssetBundle,
  );

  group('AssetBundleJson tests', () {
    test('getItem should return null if path is not found', () async {
      const dataAnwser = '{"1C Enterprise": {"color": "#814CCC"}}';

      when(mockDefaultAssetBundle
              .loadString("assets/jsons/languages_colors.json"))
          .thenAnswer((_) async => dataAnwser);

      final result = await assetBundleJson.getItem(
          path: "assets/jsons/languages_colors.json");

      expect(result, isNotNull);
      expect(result, isA<Map<String, dynamic>>());
    });
  });
}

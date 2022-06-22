import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

extension AssetGenImageExt on AssetGenImage {
  AssetImage get assetImage {
    return AssetImage(keyName);
  }
}

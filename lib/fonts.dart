import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

Future<ByteData> fetchFont() async {
  Response<List<int>> res = await Dio().get<List<int>>(
    'https://fonts.google.com/download?family=Noto_Sans_TC',
    options: Options(responseType: ResponseType.bytes),
  );
  if (res.statusCode == 200) {
    return Uint8List.fromList(res.data ?? []).buffer.asByteData();
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load font');
  }
}

Future<void> loadRemoteFonts() async {
  var fontLoader = FontLoader('Noto_Sans_TC');
  fontLoader.addFont(fetchFont());
  return await fontLoader.load();
}

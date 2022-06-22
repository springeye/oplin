import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

final fontSizes = {
  'Small': 'small',
  'Large': 'large',
  'Huge': 'huge',
  'Clear': '0'
};

dynamic getFontSize(dynamic sizeValue) {
  if (sizeValue is String && ['small', 'large', 'huge'].contains(sizeValue)) {
    return sizeValue;
  }

  if (sizeValue is double) {
    return sizeValue;
  }

  if (sizeValue is int) {
    return sizeValue.toDouble();
  }

  assert(sizeValue is String);
  final fontSize = double.tryParse(sizeValue);
  if (fontSize == null) {
    throw 'Invalid size $sizeValue';
  }
  return fontSize;
}

class TextToolbar extends StatelessWidget {
  final QuillController controller;
  final OnImagePickCallback? onImagePickCallback;
  final FilePickImpl? filePickImpl;
  final MediaPickSettingSelector? mediaPickSettingSelector;

  const TextToolbar({
    super.key,
    required this.controller,
    this.onImagePickCallback,
    this.filePickImpl,
    this.mediaPickSettingSelector,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ImageButton(
          icon: Icons.image,
          controller: controller,
          onImagePickCallback: onImagePickCallback,
          filePickImpl: filePickImpl,
          webImagePickImpl: null,
          mediaPickSettingSelector: mediaPickSettingSelector,
        ),
        ToggleCheckListButton(
          attribute: Attribute.unchecked,
          controller: controller,
          icon: Icons.check_box,
        ),
        ToggleStyleButton(
          attribute: Attribute.bold,
          icon: Icons.format_bold,
          controller: controller,
        ),
        ToggleStyleButton(
          attribute: Attribute.italic,
          icon: Icons.format_italic,
          controller: controller,
        ),
        ToggleStyleButton(
          attribute: Attribute.underline,
          icon: Icons.format_underline,
          controller: controller,
        ),
        ToggleStyleButton(
          attribute: Attribute.ol,
          controller: controller,
          icon: Icons.format_list_numbered,
        ),
        ToggleStyleButton(
          attribute: Attribute.ul,
          controller: controller,
          icon: Icons.format_list_bulleted,
        ),
        IconButton(
            onPressed: () {
              controller.formatSelection(Attribute.fromKeyValue('size', '19'));
            },
            icon: const Icon(Icons.format_size))
      ],
    );
  }
}

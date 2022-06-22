import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/bloc/show_node_cubit.dart';

import 'view/desktop/home.dart';
import 'view/mobile/home.dart';
import 'window.dart';

export 'view/app.dart';

Widget buildMainWindow(BuildContext context) {
  var targetPlatform = Theme.of(context).platform;
  if (targetPlatform == TargetPlatform.android ||
      targetPlatform == TargetPlatform.iOS) {
    return const MobileHomePage();
  } else {
    return DesktopWindow(
      child: BlocProvider(
        create: (context) => ShowNodeCubit(),
        child: const DesktopHomePage(),
      ),
    );
  }
}

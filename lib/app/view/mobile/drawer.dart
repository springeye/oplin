import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oplin/app/view/mobile/route.dart';
import 'package:oplin/app/view/mobile/settings.dart';
import 'package:oplin/bloc/app_cubit.dart';
import 'package:oplin/bloc/sync_cubit.dart';

import 'package:oplin/gen/S.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              S.of(context).settings,
              style: Theme.of(context).textTheme.titleLarge,
            )),
        ListTile(
          title: Text(S.of(context).settings),
          onTap: () {
            Navigator.push(context,
                AppPageRoute<SettingWidget>(builder: (context) {
              return const SettingWidget();
            }));
          },
        ),
        ListTile(
          title: const Text("Sync"),
          onTap: () async {
            var config = context.read<AppCubit>().state;
            await context.read<SyncCubit>().sync(config);
            EasyLoading.showToast("Sync done");
          },
        ),
      ],
    ),
  );
}

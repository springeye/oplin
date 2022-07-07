import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/app/view/desktop/folder_list.dart';
import 'package:oplin/app/view/desktop/note_edit.dart';
import 'package:oplin/app/view/desktop/note_list.dart';
import 'package:oplin/app/view/desktop/vertical_splite_view.dart';
import 'package:oplin/app/view/mobile/route.dart';
import 'package:oplin/app/view/mobile/settings.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/gen/S.dart';

class DesktopHomePage extends StatefulWidget {
  const DesktopHomePage({Key? key}) : super(key: key);

  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {
  LayoutWidgetBuilder divider =
      (BuildContext context, BoxConstraints constraints) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(top: 15),
      width: 2,
      child: Container(
        color: Colors.transparent,
      ),
    );
  };

  @override
  Widget build(BuildContext context) {
    var noteBloc = context.read<NoteBloc>();
    noteBloc.add(const NoteRefreshRequested());
    context.read<BookBloc>().add(const BookRefreshRequested());
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 30),
            ),
            Spacer(),
          ],
        ),
        Expanded(
          child: PlatformMenuBar(
            menus: _buildMacosMenuBar(context),
            body: Row(
              children: const [
                SizedBox(
                  width: 250,
                  child: FolderListWidget(),
                ),
                SizedBox(
                  width: 300,
                  child: NoteListWidget(),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(right: 8.0, left: 10),
                  child: NoteEditWidget(),
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<PlatformMenu> _buildMacosMenuBar(BuildContext context) {
    return [
      PlatformMenu(
        label: S.of(context).app_name,
        menus: [
          PlatformMenuItemGroup(
            members: [
              PlatformMenuItem(
                  label: S.of(context).settings,
                  onSelected: () {
                    Navigator.push(context, AppPageRoute<SettingWidget>(
                        builder: (BuildContext context) {
                      return const SettingWidget();
                    }));
                  }),
              if (PlatformProvidedMenuItem.hasMenu(
                  PlatformProvidedMenuItemType.quit))
                const PlatformProvidedMenuItem(
                    type: PlatformProvidedMenuItemType.quit),
            ],
          ),
        ],
      ),
    ];
  }
}

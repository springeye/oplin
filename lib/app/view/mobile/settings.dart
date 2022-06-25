import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oplin/app/view/mobile/route.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/common/nsx.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:oplin/repository/note_repository.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../bloc/app_cubit.dart';
import 'package:oplin/gen/S.dart';
import 'settings_webdav.dart';
import 'package:file_selector/file_selector.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);

    return BlocBuilder<AppCubit, AppConfig>(
      builder: (context, config) {
        var logic = context.read<AppCubit>();
        var langCode = config.locale?.languageCode ?? "other";
        return Scaffold(
          appBar: AppBar(
            toolbarHeight:
                Theme.of(context).platform == TargetPlatform.macOS ? 85 : 56,
            title: Text(lang.settings),
          ),
          body: SettingsList(
            sections: [
              SettingsSection(
                title: Text(lang.appearance),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    leading: const Icon(Icons.language),
                    title: Text(lang.select_lang),
                    trailing: const Icon(Icons.navigate_next),
                    value: Text(lang.languages(langCode)),
                    onPressed: (context) {
                      showDialog<AlertDialog>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(S.of(context).select_lang),
                              content: SizedBox(
                                height: 200,
                                width: double.maxFinite,
                                child: ListView(
                                  children: [
                                    ListTile(
                                      title: Text(S.of(context).lang_en),
                                      onTap: () {
                                        logic.setLanguage(
                                          const Locale.fromSubtags(
                                              languageCode: "en"),
                                        );
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      title: Text(S.of(context).lang_zh),
                                      onTap: () {
                                        logic.setLanguage(
                                          const Locale.fromSubtags(
                                              languageCode: "zh"),
                                        );
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      title: Text(S.of(context).lang_other),
                                      onTap: () {
                                        logic.setLanguage(null);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.style),
                    title: Text(lang.select_style),
                    trailing: const Icon(Icons.navigate_next),
                    value: Container(
                      width: 40,
                      height: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: (context) {
                      showDialog<AlertDialog>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(S.of(context).select_color),
                              content: BlockPicker(
                                availableColors: const [
                                  Colors.red,
                                  Colors.pink,
                                  Colors.purple,
                                  Colors.purpleAccent,
                                  Colors.deepPurple,
                                  Colors.indigo,
                                  Colors.blue,
                                  Colors.lightBlue,
                                  Colors.cyan,
                                  Colors.teal,
                                  Colors.green,
                                  Colors.lightGreen,
                                  Colors.lime,
                                  Colors.yellow,
                                  Colors.amber,
                                  Colors.orange,
                                  Colors.deepOrange,
                                  Colors.brown,
                                  Colors.grey,
                                  Colors.blueGrey,
                                ],
                                onColorChanged: (Color value) async {
                                  logic.setPrimaryColor(value);
                                  Navigator.pop(context);
                                },
                                pickerColor: Theme.of(context).primaryColor,
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: Text(lang.sync),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    leading: const Icon(Icons.language),
                    trailing: const Icon(Icons.navigate_next),
                    title: Text(lang.server),
                    value: const Text('WebDAV'),
                    onPressed: (context) {
                      Navigator.push(
                        context,
                        AppPageRoute<SettingWebDAV>(
                          builder: (context) {
                            return const SettingWebDAV();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: Text(lang.other),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    leading: const Icon(Icons.clear_all),
                    title: Text("清空本地数据"),
                    value: Text("请谨慎操作，清空后你的数据讲无法恢复"),
                    onPressed: (context) {
                      var repository = context.read<NoteRepository>();
                      repository.batchDeleteNote(
                          repository.getNotes().map((e) => e.uuid).toList(),
                          physics: true);
                      context
                          .read<NoteBloc>()
                          .add(const NoteRefreshRequested());
                    },
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.clear_all),
                    title: Text("导入nsx文件"),
                    value: Text("nsx格式是Synology Note Station导出的文件"),
                    onPressed: (context) async {
                      final XTypeGroup typeGroup = XTypeGroup(
                        label: 'Synology Note Station',
                        extensions: <String>['nsx'],
                      );
                      final XFile? file = await openFile(
                          acceptedTypeGroups: <XTypeGroup>[typeGroup]);
                      var result =
                          await NsxImport(File(file!.path)).getResult();
                      print(result.notes);
                      context
                          .read<BookRepository>()
                          .batchSaveBook(result.books);
                      context
                          .read<NoteRepository>()
                          .batchSaveNote(result.notes);
                      EasyLoading.showToast("import success");
                      context.read<BookBloc>().add(BookRefreshRequested());
                      context.read<NoteBloc>().add(NoteRefreshRequested());
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

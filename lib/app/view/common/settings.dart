import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oplin/app/view/common/settings_webdav.dart';
import 'package:oplin/app/view/mobile/route.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/common/nsx.dart';
import 'package:oplin/gen/fonts.gen.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:oplin/repository/note_repository.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../bloc/app_cubit.dart';
import 'package:oplin/gen/S.dart';
import 'package:file_selector/file_selector.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  SettingsTile _fontFamilyTile(BuildContext context) {
    var logic = context.read<AppCubit>();
    return SettingsTile.navigation(
      leading: const Icon(Icons.font_download),
      title: const Text("字体"),
      // trailing: const Icon(Icons.navigate_next),
      value: Text(logic.state.fontFamily ?? "系统默认"),
      onPressed: (context) {
        showDialog<AlertDialog>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("选择字体"),
                content: SizedBox(
                  height: 200,
                  width: double.maxFinite,
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text(S.of(context).system_auto),
                        onTap: () {
                          logic.setFontFamily(null);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text(FontFamily.roboto),
                        onTap: () {
                          logic.setFontFamily(FontFamily.roboto);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text(FontFamily.longCang),
                        onTap: () {
                          logic.setFontFamily(FontFamily.longCang);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text(FontFamily.jetBrainsMono),
                        onTap: () {
                          logic.setFontFamily(FontFamily.jetBrainsMono);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text(FontFamily.maShanZhengngCang),
                        onTap: () {
                          logic.setFontFamily(FontFamily.maShanZhengngCang);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  SettingsTile _langTile(BuildContext context) {
    var lang = S.of(context);

    var logic = context.watch<AppCubit>();
    var config = logic.state;
    var langCode = config.locale?.languageCode ?? "other";
    return SettingsTile.navigation(
      leading: const Icon(Icons.language),
      title: Text(lang.select_lang),
      // trailing: const Icon(Icons.navigate_next),
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
                            const Locale.fromSubtags(languageCode: "en"),
                          );
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text(S.of(context).lang_zh),
                        onTap: () {
                          logic.setLanguage(
                            const Locale.fromSubtags(languageCode: "zh"),
                          );
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text(S.of(context).system_auto),
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
    );
  }

  SettingsTile _colorTile(BuildContext context) {
    var lang = S.of(context);

    var logic = context.watch<AppCubit>();
    var config = logic.state;
    return SettingsTile.navigation(
      leading: const Icon(Icons.style),
      title: Text(lang.select_style),
      // trailing: const Icon(Icons.navigate_next),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);

    return BlocBuilder<AppCubit, AppConfig>(
      builder: (context, config) {
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
                  _langTile(context),
                  _colorTile(context),
                  _fontFamilyTile(context),
                ],
              ),
              SettingsSection(
                title: Text(lang.sync),
                tiles: <SettingsTile>[
                  _webDAVTile(lang),
                ],
              ),
              SettingsSection(
                title: Text(lang.other),
                tiles: <SettingsTile>[
                  _clearTile(),
                  _importNsxTile(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  SettingsTile _importNsxTile() {
    return SettingsTile.navigation(
      leading: const Icon(Icons.clear_all),
      title: const Text("导入nsx文件"),
      value: const Text("nsx格式是Synology Note Station导出的文件"),
      onPressed: (context) async {
        var bookRepository = context.read<BookRepository>();
        var noteBloc = context.read<NoteBloc>();
        var noteRepository = context.read<NoteRepository>();
        var bookBloc = context.read<BookBloc>();
        final XTypeGroup typeGroup = XTypeGroup(
          label: 'Synology Note Station',
          extensions: <String>['nsx'],
        );
        final XFile? file =
            await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
        var result = await NsxImport(File(file!.path)).getResult();

        bookRepository.batchSaveBook(result.books);
        noteRepository.batchSaveNote(result.notes);
        EasyLoading.showToast("import success");
        bookBloc.add(const BookRefreshRequested());
        noteBloc.add(const NoteRefreshRequested());
      },
    );
  }

  SettingsTile _clearTile() {
    return SettingsTile.navigation(
      leading: const Icon(Icons.clear_all),
      title: const Text("清空本地数据"),
      value: const Text("请谨慎操作，清空后你的数据讲无法恢复"),
      onPressed: (context) {
        var repository = context.read<NoteRepository>();
        repository.batchDeleteNote(
            repository.getNotes().map((e) => e.uuid).toList(),
            physics: true);
        context.read<NoteBloc>().add(const NoteRefreshRequested());
      },
    );
  }

  SettingsTile _webDAVTile(S lang) {
    return SettingsTile.navigation(
      leading: const Icon(Icons.language),
      // trailing: const Icon(Icons.navigate_next),
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
    );
  }
}

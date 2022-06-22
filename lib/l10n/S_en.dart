

import 'package:intl/intl.dart' as intl;
import 'S.dart';

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Notebook';

  @override
  String get settings => 'Settings';

  @override
  String notebook(String name) {
    return 'Notebook: $name';
  }

  @override
  String get create_notebook => 'Create a notebook';

  @override
  String get create => 'Create';

  @override
  String get create_note => 'Create Note';

  @override
  String get update_note => 'Update Note';

  @override
  String get unfiled => 'Unfiled';

  @override
  String get select_notebook => 'Select Notebook';

  @override
  String get ok => 'Ok';

  @override
  String get sticky => 'Sticky';

  @override
  String get delete => 'Delete';

  @override
  String get move_to => 'Move to';

  @override
  String get cancel => 'Cancel';

  @override
  String get appearance => 'Appearance';

  @override
  String get select_lang => 'Select language';

  @override
  String get select_style => 'Style';

  @override
  String get sync => 'Sync';

  @override
  String get server => 'Server';

  @override
  String get address => 'Address';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String languages(String lang) {
    return intl.Intl.select(
      lang,
      {
        'en': 'English',
        'zh': '简体中文',
        'other': 'Auto'
      },
      desc: 'select language'
    );
  }

  @override
  String get lang_en => 'English';

  @override
  String get lang_zh => '简体中文';

  @override
  String get lang_other => 'Auto';

  @override
  String get webdav_settings => 'Settings for WebDAV';

  @override
  String get webdav_settings_tips => 'Please provide login credentials for the WebDAV folder you want to synchronize.';
}

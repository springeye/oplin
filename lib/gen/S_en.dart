

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
  String get move_to_notebook => 'Move to Notebook';

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
  String get system_auto => 'Auto';

  @override
  String get webdav_settings => 'Settings for WebDAV';

  @override
  String get webdav_settings_tips => 'Please provide login credentials for the WebDAV folder you want to synchronize.';

  @override
  String get tips => 'Tips';

  @override
  String get save_message => 'The note have been modified. Do you want to save?';

  @override
  String get notebook => 'Notebook';

  @override
  String get other => 'Other';

  @override
  String get all => 'All';

  @override
  String get hint_enter_title => 'Enter title';

  @override
  String get hint_enter_search => 'Enter keyword to search';

  @override
  String get search => 'Search';

  @override
  String get toast_save_success => 'Save success';

  @override
  String notebook_by_name(String name) {
    return 'Notebook: $name';
  }

  @override
  String total_notes(int count) {
    return 'Total: $count';
  }

  @override
  String select_note_count(int count) {
    return 'Select $count notes';
  }

  @override
  String select_book_count(int count) {
    return 'Select $count books';
  }

  @override
  String get empty_notes => 'No notes';

  @override
  String datetime_format(DateTime time) {
    final intl.DateFormat timeDateFormat = intl.DateFormat('yyyy-MM-dd HH:mm:ss', localeName);
    final String timeString = timeDateFormat.format(time);

    return '$timeString';
  }

  @override
  String time_format(DateTime time) {
    final intl.DateFormat timeDateFormat = intl.DateFormat('HH:mm:ss', localeName);
    final String timeString = timeDateFormat.format(time);

    return '$timeString';
  }

  @override
  String date_format(DateTime time) {
    final intl.DateFormat timeDateFormat = intl.DateFormat('yyyy-MM-dd', localeName);
    final String timeString = timeDateFormat.format(time);

    return '$timeString';
  }

  @override
  String get select_color => 'Select color';

  @override
  String get label_url => 'Url';

  @override
  String url(String url) {
    return 'Url: $url';
  }

  @override
  String get example_url => 'example: https://www.example.com/';

  @override
  String get example_username => 'example: admin';

  @override
  String get hint_password => 'your password';
}

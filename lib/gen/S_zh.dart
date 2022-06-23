

import 'package:intl/intl.dart' as intl;
import 'S.dart';

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get app_name => '笔记本';

  @override
  String get settings => '设置';

  @override
  String notebook_by_name(String name) {
    return '笔记本: $name';
  }

  @override
  String get create_notebook => '创建笔记本';

  @override
  String get create => '创建';

  @override
  String get create_note => '创建笔记';

  @override
  String get update_note => '修改笔记';

  @override
  String get unfiled => '未分类';

  @override
  String get select_notebook => '选择笔记本';

  @override
  String get ok => '确定';

  @override
  String get sticky => '置顶';

  @override
  String get delete => '删除';

  @override
  String get move_to => '移动到';

  @override
  String get cancel => '取消';

  @override
  String get appearance => '外观';

  @override
  String get select_lang => '选择语言';

  @override
  String get select_style => '样式';

  @override
  String get sync => '同步';

  @override
  String get server => '服务器';

  @override
  String get address => '地址';

  @override
  String get username => '用户名';

  @override
  String get password => '密码';

  @override
  String languages(String lang) {
    return intl.Intl.select(
      lang,
      {
        'en': 'English',
        'zh': '简体中文',
        'other': '跟随系统'
      },
      desc: 'select language'
    );
  }

  @override
  String get lang_en => 'English';

  @override
  String get lang_zh => '简体中文';

  @override
  String get lang_other => '跟随系统';

  @override
  String get webdav_settings => 'WebDAV设置';

  @override
  String get webdav_settings_tips => '请提供您想要同步的 WebDAV 文件夹的登录凭据。';

  @override
  String get tips => 'Tips';

  @override
  String get save_message => 'The notes have been modified. Do you want to save?';

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

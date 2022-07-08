

import 'package:intl/intl.dart' as intl;
import 'S.dart';

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get app_name => '文件夹';

  @override
  String get settings => '设置';

  @override
  String get create_notebook => '创建文件夹';

  @override
  String get create => '创建';

  @override
  String get create_note => '创建笔记';

  @override
  String get update_note => '修改笔记';

  @override
  String get unfiled => '未分类';

  @override
  String get select_notebook => '选择文件夹';

  @override
  String get move_to_notebook => '移动到文件夹';

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
  String get tips => '提示';

  @override
  String get save_message => '笔记已修改。你想保存吗？';

  @override
  String get notebook => '文件夹';

  @override
  String get other => '未分类';

  @override
  String get all => '全部';

  @override
  String get hint_enter_title => '输入标题';

  @override
  String get hint_enter_search => '输入关键字进行搜索';

  @override
  String get search => '搜索';

  @override
  String get toast_save_success => '保存成功';

  @override
  String notebook_by_name(String name) {
    return '文件夹: $name';
  }

  @override
  String total_notes(int count) {
    return '共 $count 条笔记';
  }

  @override
  String select_note_count(int count) {
    return '选择 $count 条笔记';
  }

  @override
  String select_book_count(int count) {
    return '选择 $count 文件夹';
  }

  @override
  String get empty_notes => '没有笔记';

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
  String get select_color => '选择颜色';

  @override
  String get label_url => '网址';

  @override
  String url(String url) {
    return '网址： $url';
  }

  @override
  String get example_url => '示例：https://www.example.com/';

  @override
  String get example_username => '示例：admin';

  @override
  String get hint_password => '你的密码';
}

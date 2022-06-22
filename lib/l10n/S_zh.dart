

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
  String notebook(String name) {
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
}

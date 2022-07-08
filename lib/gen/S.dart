
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'S_en.dart';
import 'S_zh.dart';

/// Callers can lookup localized strings with an instance of S returned
/// by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'gen/S.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Notebook'**
  String get app_name;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @create_notebook.
  ///
  /// In en, this message translates to:
  /// **'Create a notebook'**
  String get create_notebook;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @create_note.
  ///
  /// In en, this message translates to:
  /// **'Create Note'**
  String get create_note;

  /// No description provided for @update_note.
  ///
  /// In en, this message translates to:
  /// **'Update Note'**
  String get update_note;

  /// No description provided for @unfiled.
  ///
  /// In en, this message translates to:
  /// **'Unfiled'**
  String get unfiled;

  /// No description provided for @select_notebook.
  ///
  /// In en, this message translates to:
  /// **'Select Notebook'**
  String get select_notebook;

  /// No description provided for @move_to_notebook.
  ///
  /// In en, this message translates to:
  /// **'Move to Notebook'**
  String get move_to_notebook;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @sticky.
  ///
  /// In en, this message translates to:
  /// **'Sticky'**
  String get sticky;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @move_to.
  ///
  /// In en, this message translates to:
  /// **'Move to'**
  String get move_to;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @select_lang.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get select_lang;

  /// No description provided for @select_style.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get select_style;

  /// No description provided for @sync.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get sync;

  /// No description provided for @server.
  ///
  /// In en, this message translates to:
  /// **'Server'**
  String get server;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// select language
  ///
  /// In en, this message translates to:
  /// **'{lang,select,en{English},zh{简体中文},other{Auto}}'**
  String languages(String lang);

  /// No description provided for @lang_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get lang_en;

  /// No description provided for @lang_zh.
  ///
  /// In en, this message translates to:
  /// **'简体中文'**
  String get lang_zh;

  /// No description provided for @lang_other.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get lang_other;

  /// No description provided for @webdav_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings for WebDAV'**
  String get webdav_settings;

  /// No description provided for @webdav_settings_tips.
  ///
  /// In en, this message translates to:
  /// **'Please provide login credentials for the WebDAV folder you want to synchronize.'**
  String get webdav_settings_tips;

  /// No description provided for @tips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get tips;

  /// No description provided for @save_message.
  ///
  /// In en, this message translates to:
  /// **'The note have been modified. Do you want to save?'**
  String get save_message;

  /// No description provided for @notebook.
  ///
  /// In en, this message translates to:
  /// **'Notebook'**
  String get notebook;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @hint_enter_title.
  ///
  /// In en, this message translates to:
  /// **'Enter title'**
  String get hint_enter_title;

  /// No description provided for @hint_enter_search.
  ///
  /// In en, this message translates to:
  /// **'Enter keyword to search'**
  String get hint_enter_search;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @toast_save_success.
  ///
  /// In en, this message translates to:
  /// **'Save success'**
  String get toast_save_success;

  /// notebook page title
  ///
  /// In en, this message translates to:
  /// **'Notebook: {name}'**
  String notebook_by_name(String name);

  /// total notes count
  ///
  /// In en, this message translates to:
  /// **'Total: {count}'**
  String total_notes(int count);

  /// total notes count
  ///
  /// In en, this message translates to:
  /// **'Select {count} notes'**
  String select_note_count(int count);

  /// total notes books
  ///
  /// In en, this message translates to:
  /// **'Select {count} books'**
  String select_book_count(int count);

  /// No description provided for @empty_notes.
  ///
  /// In en, this message translates to:
  /// **'No notes'**
  String get empty_notes;

  /// format datetime
  ///
  /// In en, this message translates to:
  /// **'{time}'**
  String datetime_format(DateTime time);

  /// format datetime
  ///
  /// In en, this message translates to:
  /// **'{time}'**
  String time_format(DateTime time);

  /// format datetime
  ///
  /// In en, this message translates to:
  /// **'{time}'**
  String date_format(DateTime time);

  /// No description provided for @select_color.
  ///
  /// In en, this message translates to:
  /// **'Select color'**
  String get select_color;

  /// No description provided for @label_url.
  ///
  /// In en, this message translates to:
  /// **'Url'**
  String get label_url;

  /// url
  ///
  /// In en, this message translates to:
  /// **'Url: {url}'**
  String url(String url);

  /// No description provided for @example_url.
  ///
  /// In en, this message translates to:
  /// **'example: https://www.example.com/'**
  String get example_url;

  /// No description provided for @example_username.
  ///
  /// In en, this message translates to:
  /// **'example: admin'**
  String get example_username;

  /// No description provided for @hint_password.
  ///
  /// In en, this message translates to:
  /// **'your password'**
  String get hint_password;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return SEn();
    case 'zh': return SZh();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

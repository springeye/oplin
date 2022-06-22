import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/app/view/mobile/dialog.dart';
import 'package:oplin/bloc/app_cubit.dart';

import '../../../l10n/S.dart';

class SettingWebDAV extends StatefulWidget {
  const SettingWebDAV({Key? key}) : super(key: key);

  @override
  State<SettingWebDAV> createState() => _SettingWebDAVState();
}

class _SettingWebDAVState extends State<SettingWebDAV> {
  final urlController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = false;
  String? error;
  String _url = "";

  @override
  void initState() {
    urlController.addListener(() {
      setState(() {
        _url = "${urlController.text}oplin";
      });
    });
    var logic = super.context.read<AppCubit>();
    var config = logic.state.server as WebDAVConfig?;
    if (config != null) {
      urlController.text = config.url;
      usernameController.text = config.username;
      passwordController.text = config.password;
    }
    super.initState();
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var logic = super.context.read<AppCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).webdav_settings),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () async {
              showLoading(context);
              await logic
                  .setWebDAV(
                    urlController.text,
                    usernameController.text,
                    passwordController.text,
                  )
                  .then((value) => Navigator.of(context).pop())
                  .catchError(
                (Object e) {
                  if (e is HttpException) {
                    setState(() {
                      error = e.message;
                    });
                  } else {
                    setState(() {
                      error = e.toString();
                    });
                  }
                },
              ).whenComplete(() {
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Text(S.of(context).webdav_settings_tips),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: urlController,
                  keyboardType: TextInputType.url,
                  textCapitalization: TextCapitalization.none,
                  decoration: const InputDecoration(
                    label: Text("URL"),
                    hintStyle: TextStyle(fontSize: 17),
                    hintText: '例如: https://www.example.com/',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                  autocorrect: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text("地址: $_url"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 17),
                label: Text("用户名"),
                hintText: '例如: admin',
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              autocorrect: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passwordController,
              obscureText: !showPassword,
              decoration: InputDecoration(
                label: const Text("密码"),
                suffixIcon: IconButton(
                  icon: Icon(showPassword == true
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
                hintStyle: const TextStyle(fontSize: 17),
                hintText: '输入密码',
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              autocorrect: false,
            ),
          ),
          if (error != null)
            Expanded(
              child: SingleChildScrollView(
                child: Text(error!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.red)),
              ),
            ),
        ],
      ),
    );
  }
}

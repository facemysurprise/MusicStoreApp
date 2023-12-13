import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageSelector {
  static void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Қазақша'),
                onTap: () => _changeLanguage(context, 'kk'),
              ),
              ListTile(
                title: Text('English'),
                onTap: () => _changeLanguage(context, 'en'),
              ),
              ListTile(
                title: Text('Русский'),
                onTap: () => _changeLanguage(context, 'ru'),
              ),
            ],
          ),
        );
      },
    );
  }

  static void _changeLanguage(BuildContext context, String langCode) {
    context.setLocale(Locale(langCode));
    Navigator.of(context).pop();
  }
}
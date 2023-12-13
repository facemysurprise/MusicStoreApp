// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "profile": "Profile Page",
  "phone": "Phone Number",
  "name": "Name",
  "country": "Country",
  "cart": "Your Cart",
  "animation": "Animation Page",
  "qr": "Qr Page",
  "qr2": "Scan a QR Code",
  "music": "Musical Instruments",
  "login": "Login",
  "email": "Email",
  "password": "Password",
  "register": "Register",
  "fullname": "Full Name",
  "registration": "Registration"
};
static const Map<String,dynamic> kk = {
  "profile": "Профиль",
  "phone": "Телефон Нөмірі",
  "name": "Аты Жөні",
  "country": "Мемлекет",
  "cart": "Сіздің Себетіңіз",
  "animation": "Анимация",
  "qr": "Qr",
  "qr2": "QR кодты сканерлеңіз",
  "music": "Музыкалық Инструменттер",
  "login": "Кіру",
  "email": "Email почтасы",
  "password": "Құпия сөз",
  "register": "Тіркеу",
  "fullname": "Толық Аты Жөніңіз",
  "registration": "Тіркелу"
};
static const Map<String,dynamic> ru = {
  "profile": "Страница Профиля",
  "phone": "Номер Телефона",
  "name": "Имя",
  "country": "Страна",
  "cart": "Ваша Корзина",
  "animation": "Анимация",
  "qr": "Qr",
  "qr2": "Отсканируйте QR код",
  "music": "Музыкальные Инструменты",
  "login": "Вход",
  "email": "Email почта",
  "password": "Пароль",
  "register": "Регистрация",
  "fullname": "ФИО",
  "registration": "Зарегистрироваться"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "kk": kk, "ru": ru};
}

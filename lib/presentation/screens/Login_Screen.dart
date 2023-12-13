import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/core/generated/locale_keys.g.dart';
import 'package:flutter_application_firebase/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter_application_firebase/presentation/bloc/bloc/auth_event.dart';
import 'package:flutter_application_firebase/presentation/bloc/bloc/auth_state.dart';
import 'package:flutter_application_firebase/presentation/screens/Home_screen.dart';
import 'package:flutter_application_firebase/presentation/screens/LanguageSelector.dart';
import 'package:flutter_application_firebase/presentation/screens/Registration_Screen.dart';
import 'package:flutter_application_firebase/presentation/themes/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBar()),
            (Route<dynamic> route) => false,
          );
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.login.tr()),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () => LanguageSelector.showLanguageDialog(context),
          ),
        ],),
        body: Container(
          decoration: BoxDecoration(
            gradient: AppGradients.primaryGradient
          ),
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.email.tr(),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.password.tr(),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    child: Text(LocaleKeys.login.tr()),
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        SignInRequested(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  TextButton(
                    child: Text(LocaleKeys.register.tr()),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistrationPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.thirdColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}